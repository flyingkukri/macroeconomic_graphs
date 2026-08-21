.hh_ger_unemployment_annual <- function(caption,
                                        label_ger = "Deutschland",
                                        label_hh = "Hamburg",
                                        y) {
  
  source("src/bootstrap.R")
  
  ger_raw <- with_cache(paste0("genesis_13211-0001_", DATA_START_YEAR),
                        genesis_fetch("13211-0001"))
  
  hh_raw <- with_cache(paste0("genesis_13211-0007_", DATA_START_YEAR),
                       genesis_fetch("13211-0007"))
  
  ger_dat <- ger_raw %>%
    filter(`1_variable_attribute_label` == "Insgesamt") %>%
    filter(value_unit == "Prozent") %>%
    select(5, 10, 11)
  
  hh_dat <- hh_raw %>%
    filter(`1_variable_attribute_label` == "Hamburg") %>%
    filter(value_unit == "Prozent") %>%
    select(5, 10, 11)
    
}