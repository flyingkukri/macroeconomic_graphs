ger_export_goods_monthly <- function(y_axis, caption, decimal_mark = ",", big_mark = ".") {
  raw <- with_cache(paste0("genesis_51000-0002_", DATA_START_YEAR),
                    genesis_fetch("51000-0002"))
  dat <- parse_genesis(raw, value_var = "WERTA",
                        series_name = "ger_export_goods",
                        geo         = "DEU",
                        scale       = 1 / 1e6) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01"))) |>
    dplyr::arrange(date)
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark,
                  x_breaks = "2 years")
}
