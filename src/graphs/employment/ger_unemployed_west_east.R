# Annual registered unemployed (Arbeitslose), West vs East Germany.
# Table 13211-0001 (annual). Geographic codes in 1_variable_attribute_code:
#   DF = Früheres Bundesgebiet (West), DN = Neue Länder (East).
# If parse fails: unique(raw[["1_variable_attribute_code"]])
ger_unemployed_west_east <- function(y_axis, caption, labels = NULL,
                                      decimal_mark = ",", big_mark = ".") {
  raw <- with_cache(paste0("genesis_13211-0001_", DATA_START_YEAR),
                    genesis_fetch("13211-0001"))
  west <- parse_genesis(raw,
                         value_var     = "ERW006",
                         class_filters = list("1_variable_attribute_code" = "DF"),
                         series_name   = "West",
                         geo           = "DEU-W",
                         scale         = 1 / 1e6) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  east <- parse_genesis(raw,
                         value_var     = "ERW006",
                         class_filters = list("1_variable_attribute_code" = "DN"),
                         series_name   = "East",
                         geo           = "DEU-E",
                         scale         = 1 / 1e6) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  dat <- dplyr::bind_rows(west, east)
  plot_timeseries_multi(dat, y_axis = y_axis, caption = caption,
                         labels = labels,
                         colors = c(hwwi_rubin, hwwi_blue),
                         decimal_mark = decimal_mark, big_mark = big_mark,
                         x_breaks = "2 years")
}
