# Hamburg monthly trade bar charts: total vs. excl. aircraft.
# The larger-value series (total) is drawn behind; NoAir series on top.
# Source: fetch_hh_trade_monthly() (tables 51000-0031/0035).

.hh_trade_bar <- function(direction, y_axis, caption, labels,
                            decimal_mark, big_mark, y_limits,
                            start_date = NULL, x_breaks = "2 years") {
  series_pair <- c(direction, paste0(direction, "NoAir"))
  dat <- with_cache(paste0("genesis_hh_trade_monthly_", DATA_START_YEAR),
                    fetch_hh_trade_monthly()) |>
    dplyr::filter(series %in% series_pair) |>
    dplyr::mutate(series = factor(series, levels = series_pair))
  if (!is.null(start_date))
    dat <- dplyr::filter(dat, date >= start_date)
  plot_bar_date(dat, y_axis = y_axis, caption = caption, labels = labels,
                decimal_mark = decimal_mark, big_mark = big_mark,
                x_breaks = x_breaks, y_limits = y_limits)
}

hh_export_monthly <- function(y_axis, caption, labels,
                               decimal_mark = ",", big_mark = ".", y_limits = NULL)
  .hh_trade_bar("Export", y_axis, caption, labels, decimal_mark, big_mark, y_limits)

hh_import_monthly <- function(y_axis, caption, labels,
                               decimal_mark = ",", big_mark = ".", y_limits = NULL)
  .hh_trade_bar("Import", y_axis, caption, labels, decimal_mark, big_mark, y_limits)

hh_export_pandemic <- function(y_axis, caption, labels,
                                decimal_mark = ",", big_mark = ".", y_limits = NULL)
  .hh_trade_bar("Export", y_axis, caption, labels, decimal_mark, big_mark, y_limits,
                start_date = as.Date("2019-01-01"), x_breaks = "1 year")

hh_import_pandemic <- function(y_axis, caption, labels,
                                decimal_mark = ",", big_mark = ".", y_limits = NULL)
  .hh_trade_bar("Import", y_axis, caption, labels, decimal_mark, big_mark, y_limits,
                start_date = as.Date("2019-01-01"), x_breaks = "1 year")
