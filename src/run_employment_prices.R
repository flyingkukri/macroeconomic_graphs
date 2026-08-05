source("src/bootstrap.R")
.graphs <- discover_graphs()

for (g in .graphs) {
  if (g$category %in% c("Employment", "Prices")) {
    tryCatch(
      g$render(),
      error = function(e) message("SKIPPED ", g$id, ": ", conditionMessage(e))
    )
  }
}
