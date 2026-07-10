ger_cpi <- function(y_axis, caption, y_limits = c(40, 130)) {
  raw <- with_cache(paste0("genesis_61111-0001_", DATA_START_YEAR),
                    genesis_fetch("61111-0001"))
  dat <- parse_genesis(raw,
                        value_var   = "PREIS1",
                        unit_filter = "2020=100",
                        series_name = "cpi",
                        geo         = "DEU")
  plot_timeseries(dat, y_axis = y_axis, caption = caption, y_limits = y_limits)
}
