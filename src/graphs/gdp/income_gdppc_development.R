.wdi_gdppc_dev <- function(country, y_axis, caption, decimal_mark = ".", big_mark = ",") {
  dat <- with_cache(paste0("wdi_NY.GDP.PCAP.PP.KD_", country, "_", DATA_START_YEAR),
                    fetch_wdi("NY.GDP.PCAP.PP.KD", country = country)) |>
    dplyr::arrange(date)
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark)
}

gdp_high_income_development  <- function(y_axis, caption, decimal_mark = ".", big_mark = ",")
  .wdi_gdppc_dev("HIC", y_axis, caption, decimal_mark, big_mark)

gdp_upper_middle_development <- function(y_axis, caption, decimal_mark = ".", big_mark = ",")
  .wdi_gdppc_dev("UMC", y_axis, caption, decimal_mark, big_mark)

gdp_lower_middle_development <- function(y_axis, caption, decimal_mark = ".", big_mark = ",")
  .wdi_gdppc_dev("LMC", y_axis, caption, decimal_mark, big_mark)

gdp_low_income_development   <- function(y_axis, caption, decimal_mark = ".", big_mark = ",")
  .wdi_gdppc_dev("LIC", y_axis, caption, decimal_mark, big_mark)
