# Annual bar charts for state-level and Germany trade values.
# Hamburg and LS from respective fetch helpers; Germany from GENESIS 51000-0001.

trade_export_hamburg <- function(y_axis, caption, labels,
                                  decimal_mark = ",", y_limits = c(0, 90)) {
  dat <- with_cache(paste0("genesis_hh_trade_gp19_", DATA_START_YEAR), fetch_hh_trade()) |>
    dplyr::filter(series %in% c("Export", "ExportExclTransport")) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption, labels = labels,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_import_hamburg <- function(y_axis, caption, labels,
                                  decimal_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("genesis_hh_trade_gp19_", DATA_START_YEAR), fetch_hh_trade()) |>
    dplyr::filter(series %in% c("Import", "ImportExclTransport")) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption, labels = labels,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_export_lowersaxony <- function(y_axis, caption, decimal_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("genesis_ls_trade_gp19_", DATA_START_YEAR), fetch_ls_trade()) |>
    dplyr::filter(series == "Export") |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_import_lowersaxony <- function(y_axis, caption, decimal_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("genesis_ls_trade_gp19_", DATA_START_YEAR), fetch_ls_trade()) |>
    dplyr::filter(series == "Import") |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_export_germany <- function(y_axis, caption, decimal_mark = ",", y_limits = NULL) {
  raw <- with_cache(paste0("genesis_51000-0001_", DATA_START_YEAR),
                    genesis_fetch("51000-0001"))
  dat <- parse_genesis(raw, value_var = "WERTA",
                        series_name = "Export", unit = "Mrd. EUR", geo = "DEU",
                        scale = 1 / 1e6) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01"))) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits,
            colors = c(alpha(hwwi_blue, 0.9)))
}

trade_import_germany <- function(y_axis, caption, decimal_mark = ",", y_limits = NULL) {
  raw <- with_cache(paste0("genesis_51000-0001_", DATA_START_YEAR),
                    genesis_fetch("51000-0001"))
  dat <- parse_genesis(raw, value_var = "WERTE",
                        series_name = "Import", unit = "Mrd. EUR", geo = "DEU",
                        scale = 1 / 1e6) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01"))) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits,
            colors = c(alpha(hwwi_rubin, 0.9)))
}

# ── Graph module ─────────────────────────────────────────────────────────────────────────────
# Metadata and rendering live with the implementation so discovery needs no central registry.
.graph_specs <- list(
list(id = "trade_export_hamburg", category = "Trade", label = "Hamburg Exports (total/excl. other transport equipment)",
    render = function() {
        GER <- file.path(OUT_DIR, "trade graphs/German labeling")
        EN <- file.path(OUT_DIR, "trade graphs/English labeling")
        render_graph(trade_export_hamburg("Exporte (in Mrd. EUR)", "Datenquelle: Statistisches Bundesamt (Destatis)",
            labels = c("Gesamtexporte", "Exporte ohne sonstigen Fahrzeugbau"), decimal_mark = ","),
            "Export Hamburg_ger", GER)
        render_graph(trade_export_hamburg("Exports (in Billion EUR)", "Data source: Federal statistical office (Destatis)",
            labels = c("Total Exports", "Exports excl. other transport equipment"), decimal_mark = "."), "Export Hamburg_en",
            EN)
    }),
list(id = "trade_import_hamburg", category = "Trade", label = "Hamburg Imports (total/excl. other transport equipment)",
    render = function() {
        GER <- file.path(OUT_DIR, "trade graphs/German labeling")
        EN <- file.path(OUT_DIR, "trade graphs/English labeling")
        render_graph(trade_import_hamburg("Importe (in Mrd. EUR)", "Datenquelle: Statistisches Bundesamt (Destatis)",
            labels = c("Gesamtimporte", "Importe ohne sonstigen Fahrzeugbau"), decimal_mark = ","),
            "Import Hamburg_ger", GER)
        render_graph(trade_import_hamburg("Imports (in Billion EUR)", "Data source: Federal statistical office (Destatis)",
            labels = c("Total Imports", "Imports excl. other transport equipment"), decimal_mark = "."), "Import Hamburg_en",
            EN)
    }),
list(id = "trade_export_germany", category = "Trade", label = "Germany Total Exports (annual)", render = function() {
    GER <- file.path(OUT_DIR, "trade graphs/German labeling")
    EN <- file.path(OUT_DIR, "trade graphs/English labeling")
    render_graph(trade_export_germany("Ausfuhren (in Mrd. EUR)", "Datenquelle: Statistisches Bundesamt (Destatis)",
        decimal_mark = ","), "Export Germany_ger", GER)
    render_graph(trade_export_germany("Exports (in Billion EUR)", "Data source: Federal statistical office (Destatis)",
        decimal_mark = "."), "Export Germany_en", EN)
}),
list(id = "trade_import_germany", category = "Trade", label = "Germany Total Imports (annual)", render = function() {
    GER <- file.path(OUT_DIR, "trade graphs/German labeling")
    EN <- file.path(OUT_DIR, "trade graphs/English labeling")
    render_graph(trade_import_germany("Einfuhren (in Mrd. EUR)", "Datenquelle: Statistisches Bundesamt (Destatis)",
        decimal_mark = ","), "Import Germany_ger", GER)
    render_graph(trade_import_germany("Imports (in Billion EUR)", "Data source: Federal statistical office (Destatis)",
        decimal_mark = "."), "Import Germany_en", EN)
}),
list(id = "trade_export_lowersaxony", category = "Trade", label = "Lower Saxony Exports (total)", render = function() {
    GER <- file.path(OUT_DIR, "trade graphs/German labeling")
    EN <- file.path(OUT_DIR, "trade graphs/English labeling")
    render_graph(trade_export_lowersaxony("Exporte (in Mrd. EUR)", "Datenquelle: Statistisches Bundesamt (Destatis)",
        decimal_mark = ","), "Export Lower Saxony_ger", GER)
    render_graph(trade_export_lowersaxony("Exports (in Billion EUR)", "Data source: Federal statistical office (Destatis)",
        decimal_mark = "."), "Export Lower Saxony_en", EN)
}),
list(id = "trade_import_lowersaxony", category = "Trade", label = "Lower Saxony Imports (total)", render = function() {
    GER <- file.path(OUT_DIR, "trade graphs/German labeling")
    EN <- file.path(OUT_DIR, "trade graphs/English labeling")
    render_graph(trade_import_lowersaxony("Importe (in Mrd. EUR)", "Datenquelle: Statistisches Bundesamt (Destatis)",
        decimal_mark = ","), "Import Lower Saxony_ger", GER)
    render_graph(trade_import_lowersaxony("Imports (in Billion EUR)", "Data source: Federal statistical office (Destatis)",
        decimal_mark = "."), "Import Lower Saxony_en", EN)
})
)

if (!exists("auto_run_graph_file", mode = "function")) source("src/graph_modules.R")
auto_run_graph_file("src/graphs/trade/trade_state_bars.R", .graph_specs)
