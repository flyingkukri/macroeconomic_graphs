# Quarterly employed persons, seasonally adjusted (X13 JDemetra+), Inlandskonzept.
# Table 13321-0002 (replaces retired 81000-0012). Raw values are in 1000 persons.
# If parse fails: unique(raw$value_variable_code); unique(raw[["4_variable_attribute_code"]])
ger_employed_seasonal <- function(y_axis, caption, decimal_mark = ",", big_mark = ".") {
  raw <- with_cache(paste0("genesis_13321-0002_", DATA_START_YEAR),
                    genesis_fetch("13321-0002"))
  dat <- parse_genesis(raw,
                        value_var     = "ERW002",
                        class_filters = list("4_variable_attribute_code" = "X13JDSB",
                                             "3_variable_attribute_code" = "KONZEPTA",
                                             "2_variable_attribute_code" = "DG"),
                        series_name   = "employed_seasonal",
                        geo           = "DEU",
                        scale         = 1) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark,
                  x_breaks = "2 years")
}
