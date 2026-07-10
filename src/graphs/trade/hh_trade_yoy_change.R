# Hamburg monthly trade YoY change (%), total vs. excl. aircraft.
# YoY = current month vs. same month prior year (lag 12). Source: 51000-0031/0035.

.hh_trade_yoy <- function(direction, y_axis, caption, labels, decimal_mark, y_limits) {
  series_pair <- c(direction, paste0(direction, "NoAir"))
  dat <- with_cache(paste0("genesis_hh_trade_monthly_", DATA_START_YEAR),
                    fetch_hh_trade_monthly()) |>
    dplyr::filter(series %in% series_pair) |>
    dplyr::arrange(series, date) |>
    dplyr::group_by(series) |>
    dplyr::mutate(value = (value / dplyr::lag(value, 12) - 1) * 100) |>
    dplyr::ungroup() |>
    dplyr::filter(!is.na(value), date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries_multi(dat, y_axis = y_axis, caption = caption, labels = labels,
                         decimal_mark = decimal_mark, x_breaks = "2 years",
                         y_limits = y_limits)
}

hh_export_yoy_change <- function(y_axis, caption, labels,
                                  decimal_mark = ",", y_limits = NULL)
  .hh_trade_yoy("Export", y_axis, caption, labels, decimal_mark, y_limits)

hh_import_yoy_change <- function(y_axis, caption, labels,
                                  decimal_mark = ",", y_limits = NULL)
  .hh_trade_yoy("Import", y_axis, caption, labels, decimal_mark, y_limits)
