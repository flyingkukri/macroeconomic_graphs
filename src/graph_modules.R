# Graph-module discovery and execution.
#
# A graph file exports `.graph_specs`, a list of graph definitions. Each
# definition contains id, category, label, and a zero-argument render function.
# Keeping that definition in the graph file makes the file self-contained while
# still allowing the CLI to build a project-wide catalog automatically.

graph_spec <- function(id, category, label, render, status = "stable") {
  list(
    id = id,
    category = category,
    label = label,
    render = render,
    status = status
  )
}

.graph_source_files <- function(graphs_dir = "src/graphs") {
  sort(list.files(
    graphs_dir,
    pattern = "\\.R$",
    recursive = TRUE,
    full.names = TRUE
  ))
}

validate_graph_specs <- function(specs) {
  if (!is.list(specs)) stop("Graph catalog must be a list", call. = FALSE)
  if (length(specs) == 0L) return(invisible(specs))

  required <- c("id", "category", "label", "render")
  problems <- character()

  for (i in seq_along(specs)) {
    spec <- specs[[i]]
    source_file <- spec$source_file %||% paste0("entry ", i)
    missing <- setdiff(required, names(spec))
    if (length(missing)) {
      problems <- c(problems, sprintf(
        "%s is missing: %s", source_file, paste(missing, collapse = ", ")
      ))
      next
    }
    if (!is.character(spec$id) || length(spec$id) != 1L || !nzchar(spec$id))
      problems <- c(problems, paste0(source_file, " has an invalid id"))
    if (!is.character(spec$category) || length(spec$category) != 1L || !nzchar(spec$category))
      problems <- c(problems, paste0(source_file, " has an invalid category"))
    if (!is.function(spec$render))
      problems <- c(problems, paste0(source_file, " has a non-function render field"))
  }

  ids <- vapply(specs, function(x) x$id %||% NA_character_, character(1))
  duplicate_ids <- unique(ids[!is.na(ids) & duplicated(ids)])
  if (length(duplicate_ids)) {
    problems <- c(problems, paste0(
      "Duplicate graph ids: ", paste(duplicate_ids, collapse = ", ")
    ))
  }

  if (length(problems)) {
    stop("Invalid graph catalog:\n- ", paste(problems, collapse = "\n- "), call. = FALSE)
  }
  invisible(specs)
}

discover_graphs <- function(graphs_dir = "src/graphs") {
  files <- .graph_source_files(graphs_dir)
  specs <- list()
  old_option <- getOption("hwwi.discovering")
  options(hwwi.discovering = TRUE)
  on.exit(options(hwwi.discovering = old_option), add = TRUE)

  for (file in files) {
    env <- new.env(parent = .GlobalEnv)
    sys.source(file, envir = env)
    file_specs <- env$.graph_specs
    if (is.null(file_specs)) next
    if (!is.list(file_specs)) {
      stop(file, " exports .graph_specs, but it is not a list", call. = FALSE)
    }
    for (i in seq_along(file_specs)) {
      file_specs[[i]]$source_file <- file
    }
    specs <- c(specs, file_specs)
  }

  validate_graph_specs(specs)
  specs
}

run_graph_specs <- function(specs, ids = NULL) {
  validate_graph_specs(specs)
  if (!is.null(ids)) {
    specs <- Filter(function(x) x$id %in% ids, specs)
    if (!length(specs)) stop("No matching graph id", call. = FALSE)
  }

  errors <- character()
  for (spec in specs) {
    message("Rendering ", spec$id, " ...")
    tryCatch(
      spec$render(),
      error = function(e) {
        errors <<- c(errors, paste0(spec$id, ": ", conditionMessage(e)))
      }
    )
  }
  if (length(errors)) {
    stop("Graph rendering failed:\n- ", paste(errors, collapse = "\n- "), call. = FALSE)
  }
  invisible(specs)
}

is_standalone_graph_file <- function(path) {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (!length(file_arg)) return(FALSE)
  invoked <- sub("^--file=", "", file_arg[[1]])
  identical(normalizePath(invoked, mustWork = FALSE),
            normalizePath(path, mustWork = FALSE))
}

run_standalone_graph_file <- function(path, specs) {
  if (isTRUE(getOption("hwwi.discovering")))
    return(invisible(FALSE))

  source("src/bootstrap.R")
  args <- commandArgs(trailingOnly = TRUE)
  language_flag <- grep("^--language=", args, value = TRUE)
  if (length(language_flag)) {
    language <- sub("^--language=", "", language_flag[[1]])
    if (!language %in% c("de", "en"))
      stop("--language must be 'de' or 'en'", call. = FALSE)
    options(hwwi.render.language = language)
  }
  run_graph_specs(specs)
  invisible(TRUE)
}

auto_run_graph_file <- function(path, specs) {
  if (!is_standalone_graph_file(path)) return(invisible(FALSE))
  run_standalone_graph_file(path, specs)
}

`%||%` <- function(x, y) if (is.null(x)) y else x
