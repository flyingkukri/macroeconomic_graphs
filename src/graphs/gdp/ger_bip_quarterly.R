# Quarterly German GDP from GENESIS 81000-0002. Shares cache across all functions.
# X13JDKSB = seasonally + calendar adjusted; WERTORG = original unadjusted.
# VGRPKM = chain index (2020=100); VGRPVK = chain-linked volumes (Mrd. EUR).

.ger_bip_quarterly <- function(value_var, sa_code, filter_code, series_name,
                                 y_axis, caption, decimal_mark, big_mark = ",") {
  raw <- with_cache(paste0("genesis_81000-0002_", DATA_START_YEAR),
                    genesis_fetch("81000-0002"))
  dat <- parse_genesis(raw,
                        value_var     = value_var,
                        class_filters = list("2_variable_attribute_code" = "DG",
                                             "3_variable_attribute_code" = sa_code,
                                             "4_variable_attribute_code" = filter_code),
                        series_name   = series_name,
                        geo           = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark,
                  x_breaks = "2 years")
}

ger_bip_quarterly_development <- function(y_axis, caption, decimal_mark = ",")
  .ger_bip_quarterly("VGR014", "X13JDKSB", "VGRPKM", "gdp_quarterly_level",
                       y_axis, caption, decimal_mark)

ger_bip_quarterly_growth <- function(y_axis, caption, decimal_mark = ",")
  .ger_bip_quarterly("BIP005", "X13JDKSB", "VGRPKM", "gdp_quarterly_growth",
                       y_axis, caption, decimal_mark)

ger_bip_quarterly_volume <- function(y_axis, caption, decimal_mark = ",", big_mark = ".")
  .ger_bip_quarterly("VGR014", "X13JDKSB", "VGRPVK", "gdp_quarterly_volume",
                       y_axis, caption, decimal_mark, big_mark)

ger_bip_quarterly_volume_orig <- function(y_axis, caption, decimal_mark = ",", big_mark = ".")
  .ger_bip_quarterly("VGR014", "WERTORG", "VGRPVK", "gdp_quarterly_volume_orig",
                       y_axis, caption, decimal_mark, big_mark)
