# Monthly registered unemployed (Arbeitslose, Germany total, in Mio.), seasonally adjusted.
# GENESIS 13211-0002 (monthly). ERW006 = Arbeitslose; X-13ARIMA-SEATS SA via {seasonal}.
# Shares the 13211-0002 cache with ger_unemployment_rate.
ger_registered_unemployed_monthly <- function(y_axis, caption,
                                               decimal_mark = ",", big_mark = ".") {
  raw <- with_cache(paste0("genesis_13211-0002_", DATA_START_YEAR),
                    genesis_fetch("13211-0002"))
  dat <- parse_genesis(raw,
                        value_var     = "ERW006",
                        class_filters = list("2_variable_attribute_code" = NA),
                        series_name   = "registered_unemployed",
                        geo           = "DEU",
                        scale         = 1 / 1e6) |>
    dplyr::arrange(date) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  ts_obj <- stats::ts(dat$value,
                       start     = c(as.integer(format(dat$date[1], "%Y")),
                                     as.integer(format(dat$date[1], "%m"))),
                       frequency = 12)
  dat$value <- as.numeric(seasonal::final(seasonal::seas(ts_obj)))
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark,
                  x_breaks = "2 years")
}
