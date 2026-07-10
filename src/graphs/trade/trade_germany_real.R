# Germany real exports/imports from VGR national accounts (GENESIS 81000-0027).
# Shares the same cached table across all 6 functions.
# VGRPKM = chain index (2020=100); VGRPVK = chain-linked volumes in EUR.

.ger_vgr_trade_bar <- function(value_var, filter_code, series_name, y_axis, caption,
                                 decimal_mark) {
  raw <- with_cache(paste0("genesis_81000-0027_", DATA_START_YEAR),
                    genesis_fetch("81000-0027"))
  dat <- parse_genesis(raw, value_var = value_var,
                        class_filters = list("2_variable_attribute_code" = filter_code),
                        series_name = series_name, geo = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01"))) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))
  plot_bar(dat, y_axis = y_axis, caption = caption,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series", colors = c(alpha(hwwi_blue, 0.9))) +
    ggplot2::theme(legend.position = "none")
}

trade_export_germany_real <- function(y_axis, caption, decimal_mark = ",")
  .ger_vgr_trade_bar("EXP001", "VGRPKM", "ExportReal", y_axis, caption, decimal_mark)

trade_import_germany_real <- function(y_axis, caption, decimal_mark = ",")
  .ger_vgr_trade_bar("IMP001", "VGRPKM", "ImportReal", y_axis, caption, decimal_mark)

trade_export_germany_real_goods <- function(y_axis, caption, decimal_mark = ",")
  .ger_vgr_trade_bar("EXP002", "VGRPVK", "ExportGoods", y_axis, caption, decimal_mark)

trade_import_germany_real_goods <- function(y_axis, caption, decimal_mark = ",")
  .ger_vgr_trade_bar("IMP002", "VGRPVK", "ImportGoods", y_axis, caption, decimal_mark)

trade_export_germany_real_services <- function(y_axis, caption, decimal_mark = ",")
  .ger_vgr_trade_bar("EXP003", "VGRPVK", "ExportServices", y_axis, caption, decimal_mark)

trade_import_germany_real_services <- function(y_axis, caption, decimal_mark = ",")
  .ger_vgr_trade_bar("IMP003", "VGRPVK", "ImportServices", y_axis, caption, decimal_mark)
