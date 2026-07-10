.wdi_gdppc_growth <- function(country, y_axis, caption, decimal_mark = ".") {
  dat <- with_cache(paste0("wdi_NY.GDP.PCAP.KD.ZG_", country, "_", DATA_START_YEAR),
                    fetch_wdi("NY.GDP.PCAP.KD.ZG", country = country)) |>
    dplyr::filter(!is.na(value)) |>
    dplyr::arrange(date)
  plot_bar_growth(dat, y_axis = y_axis, caption = caption, decimal_mark = decimal_mark)
}

gdp_high_income_growth   <- function(y_axis, caption, decimal_mark = ".") .wdi_gdppc_growth("HIC", y_axis, caption, decimal_mark)
gdp_upper_middle_growth  <- function(y_axis, caption, decimal_mark = ".") .wdi_gdppc_growth("UMC", y_axis, caption, decimal_mark)
gdp_lower_middle_growth  <- function(y_axis, caption, decimal_mark = ".") .wdi_gdppc_growth("LMC", y_axis, caption, decimal_mark)
gdp_low_income_growth    <- function(y_axis, caption, decimal_mark = ".") .wdi_gdppc_growth("LIC", y_axis, caption, decimal_mark)
