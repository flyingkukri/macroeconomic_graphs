# Annual bar charts for state-level and Germany trade values.
# Hamburg and LS from respective fetch helpers; Germany from GENESIS 51000-0001.

trade_export_hamburg <- function(y_axis, caption, labels,
                                  decimal_mark = ",", y_limits = c(0, 90)) {
  dat <- with_cache(paste0("genesis_hh_trade_", DATA_START_YEAR), fetch_hh_trade()) |>
    dplyr::filter(series %in% c("Export", "ExportNoAir")) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption, labels = labels,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_import_hamburg <- function(y_axis, caption, labels,
                                  decimal_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("genesis_hh_trade_", DATA_START_YEAR), fetch_hh_trade()) |>
    dplyr::filter(series %in% c("Import", "ImportNoAir")) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption, labels = labels,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_export_lowersaxony <- function(y_axis, caption, decimal_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("genesis_ls_trade_", DATA_START_YEAR), fetch_ls_trade()) |>
    dplyr::filter(series == "Export") |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", y_limits = y_limits)
}

trade_import_lowersaxony <- function(y_axis, caption, decimal_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("genesis_ls_trade_", DATA_START_YEAR), fetch_ls_trade()) |>
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
