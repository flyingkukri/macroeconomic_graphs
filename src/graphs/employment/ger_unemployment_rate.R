ger_unemployment_rate <- function(y_axis, caption, decimal_mark = ",") {
  raw <- with_cache(paste0("genesis_13211-0002_", DATA_START_YEAR),
                    genesis_fetch("13211-0002"))
  dat <- parse_genesis(raw,
                        value_var     = "ERW112",
                        class_filters = list("2_variable_attribute_code" = NA),
                        series_name   = "unemployment_rate",
                        geo           = "DEU") |>
    dplyr::arrange(date)
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, x_breaks = "2 years")
}
