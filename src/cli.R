#!/usr/bin/env Rscript
# Run from project root: Rscript src/cli.R

source("src/bootstrap.R")
invisible(lapply(
  list.files("src/graphs", pattern = "\\.R$", recursive = TRUE, full.names = TRUE),
  source
))
source("src/registry.R")

# ── helpers ───────────────────────────────────────────────────────────────────

.hr <- function() cat(strrep("─", 58), "\n", sep = "")

.read_line <- function(prompt) {
  cat(prompt)
  readLines(con = stdin(), n = 1)
}

.show_menu <- function(reg) {
  cat("\n")
  .hr()
  cat("  HWWI Macroeconomic Standard Graphs\n")
  .hr()
  cat("\n")
  cur_cat <- ""
  for (i in seq_along(reg)) {
    g <- reg[[i]]
    if (g$category != cur_cat) {
      if (nzchar(cur_cat)) cat("\n")
      cat("  ", g$category, "\n", sep = "")
      cur_cat <- g$category
    }
    cat(sprintf("    %2d  %s\n", i, g$label))
  }
  cat("\n")
  .hr()
  cat("  Enter numbers (e.g. 1,3,5-7), category names (e.g. gdp,trade),\n")
  cat("  or 'all'.\n")
  .hr()
  cat("\n")
}

.parse_selection <- function(input, reg) {
  input <- trimws(tolower(input))
  if (input == "all") return(seq_along(reg))

  cats <- tolower(sapply(reg, `[[`, "category"))
  idx  <- integer(0)

  for (token in strsplit(input, "[,\\s]+")[[1]]) {
    token <- trimws(token)
    if (!nzchar(token)) next

    if (grepl("^\\d+-\\d+$", token)) {
      parts <- as.integer(strsplit(token, "-")[[1]])
      idx   <- c(idx, seq(parts[1], parts[2]))
    } else if (grepl("^\\d+$", token)) {
      idx <- c(idx, as.integer(token))
    } else if (token %in% cats) {
      idx <- c(idx, which(cats == token))
    } else {
      cat("  Unknown token ignored:", token, "\n")
    }
  }

  unique(sort(idx[idx >= 1 & idx <= length(reg)]))
}

# ── main ──────────────────────────────────────────────────────────────────────

# Support non-interactive usage: Rscript src/cli.R [render] <selection>
# e.g. Rscript src/cli.R all
#      Rscript src/cli.R render all
#      Rscript src/cli.R gdp
#      Rscript src/cli.R 1,3,5-7
.cli_args <- commandArgs(trailingOnly = TRUE)
.cli_args <- .cli_args[!tolower(.cli_args) %in% "render"]  # strip optional "render" verb

if (length(.cli_args) > 0) {
  input <- paste(.cli_args, collapse = ",")
  .show_menu(.graph_registry)
  cat(">", input, "\n")
  selected <- .parse_selection(input, .graph_registry)
  if (length(selected) == 0) {
    cat("No valid graphs selected. Exiting.\n")
    quit(status = 1)
  }
  cat("\nWill generate", length(selected), "graph(s). Starting...\n\n")
} else {
  .show_menu(.graph_registry)
  input <- .read_line("> ")

  if (!nzchar(trimws(input))) {
    cat("No selection. Exiting.\n")
    quit(status = 0)
  }

  selected <- .parse_selection(input, .graph_registry)

  if (length(selected) == 0) {
    cat("No valid graphs selected. Exiting.\n")
    quit(status = 0)
  }

  cat("\nWill generate:\n")
  for (i in selected) cat(sprintf("  [%d] %s\n", i, .graph_registry[[i]]$label))
  cat("\nProceed? [Y/n] ")
  confirm <- readLines(con = stdin(), n = 1)

  if (tolower(trimws(confirm)) %in% c("n", "no")) {
    cat("Cancelled.\n")
    quit(status = 0)
  }
}

cat("\n")
errors  <- character(0)
n_total <- length(selected)

for (k in seq_along(selected)) {
  i <- selected[[k]]
  g <- .graph_registry[[i]]
  cat(sprintf("[%d/%d] %s ... ", k, n_total, g$label))
  t0 <- proc.time()[["elapsed"]]
  tryCatch({
    g$render()
    cat(sprintf("done (%.0fs)\n", proc.time()[["elapsed"]] - t0))
  }, error = function(e) {
    cat("FAILED\n")
    errors <<- c(errors, sprintf("[%d] %s: %s", i, g$label, conditionMessage(e)))
  })
}

cat("\n")
.hr()
if (length(errors)) {
  cat("  Errors:\n")
  for (e in errors) cat("  ✗ ", e, "\n", sep = "")
} else {
  cat(sprintf("  ✓ %d graph(s) generated in out/\n", n_total))
}
.hr()
cat("\n")
