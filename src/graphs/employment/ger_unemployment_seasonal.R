# Quarterly ILO unemployment rate (%), seasonally adjusted (X13 JDemetra+).
# Computed as (Erwerbspersonen - Erwerbstätige) / Erwerbspersonen * 100.
# Tables: 13321-0006 (Erwerbspersonen), 13321-0002 (Erwerbstätige), Wohnortkonzept, X13JDSB.
ger_unemployment_seasonal <- function(y_axis, caption, decimal_mark = ",", big_mark = ".") {
  raw_ep <- with_cache(paste0("genesis_13321-0006_", DATA_START_YEAR),
                        genesis_fetch("13321-0006"))
  raw_et <- with_cache(paste0("genesis_13321-0002_", DATA_START_YEAR),
                        genesis_fetch("13321-0002"))
  erwerbspersonen <- parse_genesis(raw_ep,
                                    value_var     = "ERW001",
                                    class_filters = list("4_variable_attribute_code" = "X13JDSB",
                                                         "2_variable_attribute_code" = "DG"),
                                    series_name   = "ep",
                                    geo           = "DEU")
  erwerbstaetige <- parse_genesis(raw_et,
                                   value_var     = "ERW002",
                                   class_filters = list("4_variable_attribute_code" = "X13JDSB",
                                                        "3_variable_attribute_code" = "KONZEPTW",
                                                        "2_variable_attribute_code" = "DG"),
                                   series_name   = "et",
                                   geo           = "DEU")
  dat <- dplyr::inner_join(
    dplyr::select(erwerbspersonen, date, ep = value),
    dplyr::select(erwerbstaetige,  date, et = value),
    by = "date"
  ) |>
    dplyr::transmute(date,
                     value  = (ep - et) / ep * 100,
                     series = "unemployment_rate_seasonal",
                     unit   = "%",
                     geo    = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark,
                  x_breaks = "2 years")
}
