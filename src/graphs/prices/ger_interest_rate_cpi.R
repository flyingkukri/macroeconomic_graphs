# Dual-axis: ECB deposit facility rate (left, %) and German CPI inflation rate (right, %).
# ECB rate fetched from FRED public CSV (ECBDFR series, daily → monthly average).
# Inflation from Destatis GENESIS table 61111-0002 (monthly YoY CPI change).

.fetch_ecb_deposit_rate <- function(start_year) {
  r <- tryCatch(
    httr2::request("https://fred.stlouisfed.org/graph/fredgraph.csv") |>
      httr2::req_url_query(id = "ECBDFR") |>
      httr2::req_perform() |>
      httr2::resp_body_string(),
    error = function(e) NULL
  )
  if (is.null(r)) stop("Could not fetch ECB deposit rate from FRED")
  raw <- utils::read.csv(textConnection(r), stringsAsFactors = FALSE)
  raw$date   <- as.Date(raw$observation_date)
  raw$value  <- suppressWarnings(as.numeric(raw$ECBDFR))
  raw <- raw[!is.na(raw$value) & raw$date >= as.Date(paste0(start_year, "-01-01")), ]
  # Compute monthly average from daily data
  raw$month <- format(raw$date, "%Y-%m")
  monthly <- tapply(raw$value, raw$month, mean, na.rm = TRUE)
  tibble::tibble(
    date   = as.Date(paste0(names(monthly), "-01")),
    value  = as.numeric(monthly),
    series = "ecb_deposit_rate",
    unit   = "%",
    geo    = "EA"
  )
}

ger_interest_rate_cpi <- function(caption,
                                   label_rate       = "EZB-Einlagenzins",
                                   label_inflation  = "Inflationsrate",
                                   y_axis_left      = "EZB-Einlagenzins (in %)",
                                   y_axis_right     = "Inflationsrate (in %)",
                                   decimal_mark     = ",") {
  ecb <- with_cache(paste0("ecb_deposit_rate_", DATA_START_YEAR),
                    .fetch_ecb_deposit_rate(DATA_START_YEAR)) |>
    dplyr::mutate(series = label_rate)

  inflation <- fetch_ger_cpi_yoy(series_name = label_inflation)

  dat <- dplyr::bind_rows(ecb, inflation)
  plot_dual_axis(dat, caption = caption,
                  y_axis_left  = y_axis_left,
                  y_axis_right = y_axis_right,
                  series_left  = label_rate,
                  series_right = label_inflation,
                  decimal_mark = decimal_mark,
                  x_breaks     = "2 years")
}
