# Annual German GDP from GENESIS 81000-0001. Shares cache across all three functions.
# VGRPKM = chain index (2020=100); VGRPVK = chain-linked volumes (Mrd. EUR);
# VGRJPM = nominal current prices (Mrd. EUR).

.ger_bip_annual <- function(value_var, filter_code, series_name, y_axis, caption,
                              decimal_mark, big_mark = ",") {
  raw <- with_cache(paste0("genesis_81000-0001_", DATA_START_YEAR),
                    genesis_fetch("81000-0001"))
  dat <- parse_genesis(raw,
                        value_var     = value_var,
                        class_filters = list("2_variable_attribute_code" = filter_code),
                        series_name   = series_name,
                        geo           = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark)
}

ger_bip_annual_development <- function(y_axis, caption, decimal_mark = ",")
  .ger_bip_annual("VGR014", "VGRPKM", "gdp_level_annual", y_axis, caption, decimal_mark)

ger_bip_annual_growth <- function(y_axis, caption, decimal_mark = ",")
  .ger_bip_annual("BIP005", "VGRPKM", "gdp_growth_annual", y_axis, caption, decimal_mark)

ger_bip_annual_volume <- function(y_axis, caption, decimal_mark = ",", big_mark = ".")
  .ger_bip_annual("VGR014", "VGRPVK", "gdp_annual_volume", y_axis, caption, decimal_mark, big_mark)

ger_nominal_gdp <- function(y_axis, caption, decimal_mark = ",", big_mark = ".")
  .ger_bip_annual("VGR014", "VGRJPM", "gdp_nominal_annual", y_axis, caption, decimal_mark, big_mark)
