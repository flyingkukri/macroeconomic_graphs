# Apply X-13ARIMA-SEATS seasonal adjustment to a standard tibble(date, value, ...).
# Requires: install.packages(c("seasonal", "x13binary"))
# Falls back to unadjusted data if package unavailable or series too short.
seasonal_adjust <- function(dat) {
  if (!requireNamespace("seasonal", quietly = TRUE)) return(dat)
  dat <- dplyr::arrange(dat, date)
  start_yr  <- as.integer(format(dat$date[1], "%Y"))
  start_mon <- as.integer(format(dat$date[1], "%m"))
  x <- ts(dat$value, start = c(start_yr, start_mon), frequency = 12)
  sa <- tryCatch(
    seasonal::final(seasonal::seas(x, x11 = "")),
    error = function(e) x
  )
  dat$value <- as.numeric(sa)
  dat
}
