.wdi_gdp_line <- function(indicator, country, scale = 1, y_axis, caption,
                           decimal_mark = ".", big_mark = ",", y_limits = NULL) {
  dat <- with_cache(paste0("wdi_", indicator, "_", country, "_", DATA_START_YEAR),
                    fetch_wdi(indicator, country = country)) |>
    dplyr::mutate(value = value * scale) |>
    dplyr::arrange(date)
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark, y_limits = y_limits)
}

.wdi_gdp_bar <- function(indicator, country, scale = 1, y_axis, caption,
                          decimal_mark = ".") {
  dat <- with_cache(paste0("wdi_", indicator, "_", country, "_", DATA_START_YEAR),
                    fetch_wdi(indicator, country = country)) |>
    dplyr::mutate(value = value * scale) |>
    dplyr::filter(!is.na(value)) |>
    dplyr::arrange(date)
  plot_bar_growth(dat, y_axis = y_axis, caption = caption, decimal_mark = decimal_mark)
}

gdp_world_development  <- function(y_axis, caption, decimal_mark = ".", big_mark = ",", y_limits = c(55e3, 100e3))
  .wdi_gdp_line("NY.GDP.MKTP.KD", "1W", 1 / 1e9, y_axis, caption, decimal_mark, big_mark, y_limits)

gdp_germany_development <- function(y_axis, caption, decimal_mark = ".", big_mark = ",")
  .wdi_gdp_line("NY.GDP.MKTP.KD", "DEU", 1 / 1e9, y_axis, caption, decimal_mark, big_mark)

gdp_world_growth   <- function(y_axis, caption, decimal_mark = ".")
  .wdi_gdp_bar("NY.GDP.MKTP.KD.ZG", "1W", 1, y_axis, caption, decimal_mark)

gdp_germany_growth <- function(y_axis, caption, decimal_mark = ".")
  .wdi_gdp_bar("NY.GDP.MKTP.KD.ZG", "DEU", 1, y_axis, caption, decimal_mark)
