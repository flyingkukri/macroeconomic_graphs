# Monthly CPI year-on-year inflation rate for Germany.
# Computed from CPI level (PREIS1, table 61111-0002) via 12-month lag.
ger_inflation_rate <- function(y_axis, caption, decimal_mark = ",") {
  dat <- fetch_ger_cpi_yoy()
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, x_breaks = "5 years")
}

# ── Graph module ─────────────────────────────────────────────────────────────────────────────
# Metadata and rendering live with the implementation so discovery needs no central registry.
.graph_specs <- list(
list(id = "ger_inflation_rate", category = "Prices", label = "Germany Inflation Rate (monthly YoY)",
    render = function() {
        GER <- file.path(OUT_DIR, "prices graphs/German labeling")
        EN <- file.path(OUT_DIR, "prices graphs/English labeling")
        render_graph(ger_inflation_rate("Inflationsrate (Veränderung gg. Vj., in %)", "Datenquelle: Statistisches Bundesamt (Destatis)"),
            "GER inflation rate monthly_ger", GER)
        render_graph(ger_inflation_rate("Inflation Rate (change vs. prev. year, in %)", "Data source: Federal statistical office (Destatis)",
            decimal_mark = "."), "GER inflation rate monthly_en", EN)
    })
)

if (!exists("auto_run_graph_file", mode = "function")) source("src/graph_modules.R")
auto_run_graph_file("src/graphs/prices/ger_inflation_rate.R", .graph_specs)
