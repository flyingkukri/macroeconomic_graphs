source("src/bootstrap.R")
.graphs <- discover_graphs()

for (g in .graphs) {
  if (g$category == "GDP") {
    tryCatch(
      g$render(),
      error = function(e) message("SKIPPED ", g$id, ": ", conditionMessage(e))
    )
  }
}
