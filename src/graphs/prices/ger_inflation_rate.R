# Monthly CPI year-on-year inflation rate for Germany.
# Computed from CPI level (PREIS1, table 61111-0002) via 12-month lag.
ger_inflation_rate <- function(y_axis, caption, decimal_mark = ",") {
  dat <- fetch_ger_cpi_yoy()
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, x_breaks = "5 years")
}
