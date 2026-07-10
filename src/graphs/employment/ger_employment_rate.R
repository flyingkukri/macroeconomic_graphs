# Annual Erwerbsquote (labour force participation rate) for Germany.
# Computed as: annual-average Erwerbspersonen (13321-0006, KONZEPTW, original)
#              divided by Bevölkerungsstand (12411-0001, Dec-31 reference).
# Replaces retired table 81000-0011 (ERW088 no longer published directly).
ger_employment_rate <- function(y_axis, caption, decimal_mark = ",") {
  raw_ep  <- with_cache(paste0("genesis_13321-0006_", DATA_START_YEAR),
                         genesis_fetch("13321-0006"))
  raw_pop <- with_cache(paste0("genesis_12411-0001_", DATA_START_YEAR),
                         genesis_fetch("12411-0001"))

  # Quarterly Erwerbspersonen (original, not SA) → annual average
  ep_q <- raw_ep[
    !is.na(raw_ep$value_variable_code) & raw_ep$value_variable_code == "ERW001" &
    !is.na(raw_ep[["4_variable_attribute_code"]]) &
      raw_ep[["4_variable_attribute_code"]] == "WERTORG" &
    !is.na(raw_ep[["2_variable_attribute_code"]]) &
      raw_ep[["2_variable_attribute_code"]] == "DG" &
    !is.na(raw_ep$value) & raw_ep$value != "-", ]
  ep_q$ep_val <- as.numeric(gsub(",", ".", ep_q$value)) * 1000
  ep_a <- stats::aggregate(ep_val ~ time, data = ep_q, FUN = mean)

  # Population at Dec 31 (Anzahl, not thousands)
  pop <- raw_pop[!is.na(raw_pop$value_variable_code) &
                   !is.na(raw_pop$value) & raw_pop$value != "-", ]
  pop$year    <- substr(pop$time, 1, 4)
  pop$pop_val <- as.numeric(gsub(",", ".", pop$value))
  pop_a <- stats::aggregate(pop_val ~ year, data = pop, FUN = max)

  merged <- merge(ep_a, pop_a, by.x = "time", by.y = "year")
  merged$rate <- merged$ep_val / merged$pop_val * 100
  merged <- merged[order(merged$time), ]

  dat <- tibble::tibble(
    date   = as.Date(paste0(merged$time, "-01-01")),
    value  = merged$rate,
    series = "erwerbsquote",
    unit   = "%",
    geo    = "DEU"
  ) |> dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))

  plot_timeseries(dat, y_axis = y_axis, caption = caption, decimal_mark = decimal_mark)
}
