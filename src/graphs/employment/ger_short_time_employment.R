# Dual-axis: short-time workers (Kurzarbeiter, left) and unemployment rate (right).
# Table 13211-0002. ERW064 = Kurzarbeiter (Anzahl → scale 1/1000 → Tsd.),
# ERW112 = Arbeitslosenquote (%). Both filtered to 2_variable_attribute_label = "Insgesamt".
ger_short_time_employment <- function(caption,
                                       label_kurzarbeit  = "Kurzarbeiter",
                                       label_unemployment = "Arbeitslosenquote",
                                       y_axis_left       = "Kurzarbeiter (in Tsd.)",
                                       y_axis_right      = "Arbeitslosenquote in %",
                                       decimal_mark      = ",",
                                       y_max_right       = NULL) {
  raw <- with_cache(paste0("genesis_13211-0002_", DATA_START_YEAR),
                    genesis_fetch("13211-0002"))
  kurzarbeit <- parse_genesis(raw,
                               value_var     = "ERW064",
                               class_filters = list("2_variable_attribute_code" = NA),
                               series_name   = label_kurzarbeit,
                               geo           = "DEU",
                               scale         = 1 / 1000) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  unemployment <- parse_genesis(raw,
                                 value_var     = "ERW112",
                                 class_filters = list("2_variable_attribute_code" = NA),
                                 series_name   = label_unemployment,
                                 geo           = "DEU") |>
    dplyr::arrange(date) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  dat <- dplyr::bind_rows(kurzarbeit, unemployment)
  plot_dual_axis(dat, caption = caption,
                  y_axis_left  = y_axis_left,
                  y_axis_right = y_axis_right,
                  series_left  = label_kurzarbeit,
                  series_right = label_unemployment,
                  colors       = c(hwwi_rubin, hwwi_blue),
                  decimal_mark = decimal_mark,
                  y_max_right  = y_max_right)
}
