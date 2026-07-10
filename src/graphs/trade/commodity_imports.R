# Monthly imports by commodity group (top 4 SITC groups).
# Germany from table 51000-0006; Hamburg from 51000-0035.

.commodity_imports_base <- function(table, geo, class_filters_extra = list(),
                                     extra_fetch_args = list(), cache_prefix,
                                     commodity_codes, y_axis, caption, labels = NULL,
                                     decimal_mark = ",", big_mark = ".") {
  codes_key <- paste(commodity_codes, collapse = ",")
  raw <- with_cache(
    paste0(cache_prefix, codes_key, "_", DATA_START_YEAR),
    do.call(genesis_fetch, c(list(table, DATA_START_YEAR,
                                   classifyingvariable1 = "EGW3",
                                   classifyingkey1      = codes_key),
                              extra_fetch_args))
  )
  dat_list <- lapply(commodity_codes, function(code) {
    tryCatch(
      parse_genesis(raw, value_var = "WERTE",
                    class_filters = c(class_filters_extra,
                                      list("3_variable_attribute_code" = code)),
                    series_name   = code, geo = geo, scale = 1 / 1e6),
      error = function(e) NULL
    )
  })
  dat <- dplyr::bind_rows(dat_list[!sapply(dat_list, is.null)]) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries_multi(dat, y_axis = y_axis, caption = caption, labels = labels,
                         colors = c(hwwi_blue, hwwi_dark_blue, hwwi_dark_grey,
                                    hwwi_dark_rubin, hwwi_rubin, hwwi_light_blue),
                         decimal_mark = decimal_mark, big_mark = big_mark,
                         x_breaks = "2 years")
}

commodity_imports_germany <- function(y_axis, caption, labels = NULL,
                                       commodity_codes = c("EGW669", "EGW518", "EGW522", "EGW646"),
                                       decimal_mark = ",", big_mark = ".")
  .commodity_imports_base("51000-0006", "DEU",
                           cache_prefix     = "genesis_51000-0006_",
                           commodity_codes  = commodity_codes,
                           y_axis = y_axis, caption = caption, labels = labels,
                           decimal_mark = decimal_mark, big_mark = big_mark)

commodity_imports_hamburg <- function(y_axis, caption, labels = NULL,
                                       commodity_codes = c("EGW669", "EGW518", "EGW522", "EGW646"),
                                       decimal_mark = ",", big_mark = ".")
  .commodity_imports_base("51000-0035", "HH",
                           class_filters_extra = list("2_variable_attribute_code" = "02"),
                           extra_fetch_args    = list(regionalvariable = "DLANDX",
                                                      regionalkey      = "02"),
                           cache_prefix        = "genesis_51000-0035_HH_",
                           commodity_codes     = commodity_codes,
                           y_axis = y_axis, caption = caption, labels = labels,
                           decimal_mark = decimal_mark, big_mark = big_mark)
