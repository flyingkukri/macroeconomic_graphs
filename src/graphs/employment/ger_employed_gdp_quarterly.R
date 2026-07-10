# Dual-axis: employed persons (left, in 1000) and GDP (right, Mrd. EUR), quarterly SA.
# Employment: GENESIS 13321-0002, ERW002, X13JDSB (seasonal), KONZEPTA (Arbeitsort), DG.
# GDP: GENESIS 81000-0002, VGR014, X13JDKSB (SA+CA), VGRPVK (chain-linked volume).
ger_employed_gdp_quarterly <- function(caption,
                                        label_employed = "Erwerbstätige",
                                        label_bip      = "BIP",
                                        y_axis_left    = "Erwerbstätige (in Tsd.)",
                                        y_axis_right   = "BIP nach Quartalen (Mrd. EUR)",
                                        decimal_mark   = ",", big_mark = ".") {
  raw_emp <- with_cache(paste0("genesis_13321-0002_", DATA_START_YEAR),
                         genesis_fetch("13321-0002"))
  employed <- parse_genesis(raw_emp,
                             value_var     = "ERW002",
                             class_filters = list("4_variable_attribute_code" = "X13JDSB",
                                                   "3_variable_attribute_code" = "KONZEPTA",
                                                   "2_variable_attribute_code" = "DG"),
                             series_name   = label_employed,
                             geo           = "DEU",
                             scale         = 1) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))

  raw_gdp <- with_cache(paste0("genesis_81000-0002_", DATA_START_YEAR),
                         genesis_fetch("81000-0002"))
  gdp <- parse_genesis(raw_gdp,
                        value_var     = "VGR014",
                        class_filters = list("2_variable_attribute_code" = "DG",
                                              "3_variable_attribute_code" = "X13JDKSB",
                                              "4_variable_attribute_code" = "VGRPVK"),
                        series_name   = label_bip,
                        geo           = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))

  dat <- dplyr::bind_rows(employed, gdp)
  plot_dual_axis(dat, caption = caption,
                  y_axis_left  = y_axis_left,
                  y_axis_right = y_axis_right,
                  series_left  = label_employed,
                  series_right = label_bip,
                  colors       = c(hwwi_rubin, hwwi_blue),
                  decimal_mark = decimal_mark,
                  big_mark     = big_mark,
                  x_breaks     = "2 years",
                  y_min_at_zero = FALSE)
}
