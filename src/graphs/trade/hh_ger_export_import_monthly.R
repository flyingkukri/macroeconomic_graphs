#.hh_ger_export_import_monthly <- function(caption,
#                                          label_ger = "Deutschland",
#                                          label_hh = "Hamburg",
#                                          y_axis_left = "Hamburg: Export/Import in Tsd. €",
#                                          y_axis_right = "Deutschland: Export/Import in Tsd. €",
#                                          decimal_mark = ",",
#                                          big_mark = ".") {
  source("src/bootstrap.R")

  ger_raw <- with_cache(paste0("genesis_51000-0002_", DATA_START_YEAR),
                        genesis_fetch("51000-0002"))
  hh_raw <- with_cache(paste0("genesis_51000-0031_", DATA_START_YEAR),
                        genesis_fetch("51000-0031"))
  
  ger_dat <- ger_raw %>%
    dplyr::filter(value_variable_label %in% c("Einfuhr: Wert", "Ausfuhr: Wert")) %>%
    dplyr::select(5,8,13,14,17) %>%
    mutate(
      monat = as.integer(str_extract(`1_variable_attribute_code`, "\\d+")),
      date = ymd(paste(time, monat, "01", sep = "-"))
    ) %>%
    select(date, value, 5, 3) %>%
    rename(
      series = 3,
      geo = 4
    ) %>%
      arrange(date)
  
  hh_dat <- hh_raw %>%
    dplyr::filter(value_variable_label %in% c("Einfuhr: Wert", "Ausfuhr: Wert")) %>%
    dplyr::filter(`2_variable_attribute_code` == "02") %>%
    dplyr::select(5,8,13,14,17) %>%
    mutate(
      monat = as.integer(str_extract(`1_variable_attribute_code`, "\\d+")),
      date = ymd(paste(time, monat, "01", sep = "-"))
    ) %>%
    select(date, value, 5, 3) %>%
    rename(
      series = 3,
      geo = 4
    ) %>%
      arrange(date)
  
  dat <- bind_rows(ger_dat, hh_dat) %>%
    mutate(value = as.numeric(value, scientific = FALSE)) 
  
  plot_dual_axis(
    dat = dat,
    y_axis = "",
    labels = NULL,
    caption = "Datenquelle",
    decimal_mark = ",", big_mark = ".",
    colors = c(hwwi_rubin, hwwi_blue), x_breaks = "1 year",
    y_limits = NULL, angle = 45 
  )

}