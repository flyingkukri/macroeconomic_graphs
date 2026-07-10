source("src/bootstrap.R")
invisible(lapply(list.files("src/graphs", pattern = "\\.R$", recursive = TRUE, full.names = TRUE), source))
source("src/registry.R")

for (g in .graph_registry) {
  if (g$category %in% c("Employment", "Prices")) {
    tryCatch(
      g$render(),
      error = function(e) message("SKIPPED ", g$id, ": ", conditionMessage(e))
    )
  }
}
