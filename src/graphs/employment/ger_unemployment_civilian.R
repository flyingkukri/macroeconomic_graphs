# Two annual unemployment rates from table 13211-0001 (Insgesamt):
#   ERW112 = Arbeitslosenquote aller zivilen Erwerbspersonen (all civilian)
#   ERW113 = Arbeitslosenquote abhängiger ziviler Erwerbspersonen (dependent civilian)
# If variable codes are wrong, inspect:
#   unique(with_cache("genesis_13211-0001_raw", genesis_fetch("13211-0001"))$value_variable_code)
ger_unemployment_civilian <- function(y_axis, caption,
                                       label_all, label_dep,
                                       decimal_mark = ",") {
  raw <- with_cache(paste0("genesis_13211-0001_", DATA_START_YEAR),
                    genesis_fetch("13211-0001"))
  rate_all <- parse_genesis(raw,
                              value_var     = "ERW112",
                              class_filters = list("1_variable_attribute_code" = NA_character_),
                              series_name   = label_all,
                              geo           = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  rate_dep <- parse_genesis(raw,
                              value_var     = "ERW116",
                              class_filters = list("1_variable_attribute_code" = NA_character_),
                              series_name   = label_dep,
                              geo           = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  dat <- dplyr::bind_rows(rate_all, rate_dep)
  plot_timeseries_multi(dat, y_axis = y_axis, caption = caption,
                         colors = c(hwwi_rubin, hwwi_blue),
                         decimal_mark = decimal_mark,
                         x_breaks = "2 years")
}
