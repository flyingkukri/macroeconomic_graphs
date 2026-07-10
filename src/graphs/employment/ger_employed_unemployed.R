# Dual Y-axis: employed (left, Mio.) and registered unemployed (right, Mio.), annual.
# Sources: Erwerbstätige from 81000-0015 (ETR/VGR, Inlandskonzept);
#          Arbeitslose from 13211-0001 (BA registered, Insgesamt).
# Start from 1991 to match reference (reunified Germany historical series).
ger_employed_unemployed <- function(caption,
                                     label_employed   = "Erwerbstätige",
                                     label_unemployed = "Arbeitslose",
                                     y_axis_left      = "Erwerbstätige (in Mio.)",
                                     y_axis_right     = "Arbeitslose (in Mio.)",
                                     decimal_mark     = ",",
                                     big_mark         = ".") {
  raw_emp   <- with_cache("genesis_81000-0015_1991",
                           genesis_fetch("81000-0015", start_year = 1991))
  raw_unemp <- with_cache("genesis_13211-0001_1991",
                           genesis_fetch("13211-0001", start_year = 1991))
  employed <- parse_genesis(raw_emp,
                             value_var     = "ERW063",
                             class_filters = list("2_variable_attribute_code" = NA_character_),
                             series_name   = label_employed,
                             geo           = "DEU",
                             scale         = 1 / 1e3) |>
    dplyr::filter(date >= as.Date("1991-01-01"))
  unemployed <- parse_genesis(raw_unemp,
                               value_var     = "ERW006",
                               class_filters = list("1_variable_attribute_code" = NA_character_),
                               series_name   = label_unemployed,
                               geo           = "DEU",
                               scale         = 1 / 1e6) |>
    dplyr::filter(date >= as.Date("1991-01-01"))
  dat <- dplyr::bind_rows(employed, unemployed)
  plot_dual_axis(dat, caption = caption,
                  y_axis_left  = y_axis_left,
                  y_axis_right = y_axis_right,
                  series_left  = label_employed,
                  series_right = label_unemployed,
                  decimal_mark = decimal_mark,
                  big_mark     = big_mark,
                  x_breaks     = "5 years")
}
