82111-0010
81000-0001


#hh_ger_bip_annual_nominal <- function(y_axis, caption, decimal_mark = ",") {

source("src/bootstrap.R")
  
  ger_raw <- with_cache(paste0("genesis_81000-0001_", DATA_START_YEAR),
                    genesis_fetch("81000-0001"))
  
  ger_dat <- parse_genesis(
    ger_raw,
    value_var = "VGR014",
    class_filters = list("2_variable_attribute_code" = "VGRJPM"),
    series_name = "gdp_nominal_ger",
    geo = "DEU",
    scale = 1*1000
  )
  
  hh_raw <- with_cache(paste0("genesis_82111-0010_", DATA_START_YEAR),
                       genesis_fetch("82111-0010"))
  
  hh_dat <- parse_genesis(
    hh_raw,
    value_var = "BIP006",
    class_filters = list(`1_variable_attribute_code` = "02"),
    series_name = "gdp_nominal_hh",
    geo = "DEU",
    scale = 1
  )
  
  
  dat <- dplyr::bind_rows(hh_dat, ger_dat)
  
  plot_dual_axis(
    dat = dat,
    caption = "Quelle: Statistisches Bundesamt",
    y_axis_left = "Bruttoinlandsprodukt Hamburg",
    y_axis_right = "Bruttoinlandsprodukt Deutschland",
    series_left = "gdp_nominal_hh",
    series_right = "gdp_nominal_ger",
    decimal_mark = ",", big_mark = ".",
    colors = c(hwwi_dark_rubin, hwwi_dark_blue), x_breaks = "2 years",
    y_max_right = NULL, y_min_at_zero = TRUE
  )
  
  
  
  
#}




.graph_specs <- list(
  list(
    id = "hh_ger_nominal_bip_annual",
    category = "GDP",
    label = "Hamburg"
  )
)