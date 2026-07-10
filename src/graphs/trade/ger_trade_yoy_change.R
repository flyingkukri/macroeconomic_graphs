# Germany monthly trade: absolute year-on-year change (Mrd. EUR), table 51000-0002.

.ger_trade_yoy <- function(value_var, series_name, y_axis, caption, decimal_mark,
                             show_trend = FALSE, x_breaks = "2 years",
                             start_date = as.Date(paste0(DATA_START_YEAR, "-01-01"))) {
  raw <- with_cache(paste0("genesis_51000-0002_", DATA_START_YEAR),
                    genesis_fetch("51000-0002"))
  dat <- parse_genesis(raw, value_var = value_var, series_name = series_name,
                        geo = "DEU", scale = 1 / 1e6) |>
    dplyr::arrange(date) |>
    dplyr::mutate(value = value - dplyr::lag(value, 12)) |>
    dplyr::filter(!is.na(value), date >= start_date)

  if (show_trend) {
    ggplot2::ggplot(dat, ggplot2::aes(x = date, y = value)) +
      ggplot2::geom_line(linewidth = 1.6, color = hwwi_blue) +
      ggplot2::stat_smooth(method = "lm", formula = y ~ x, se = FALSE,
                            linetype = "dashed", linewidth = 1, color = hwwi_blue,
                            fullrange = FALSE) +
      ggplot2::scale_x_date(date_breaks = x_breaks, date_labels = "%Y") +
      ggplot2::scale_y_continuous(
        labels = function(x) format(x, decimal.mark = decimal_mark, scientific = FALSE)
      ) +
      ggplot2::labs(x = "", y = y_axis, caption = caption) +
      hwwi_theme()
  } else {
    plot_timeseries(dat, y_axis = y_axis, caption = caption,
                    decimal_mark = decimal_mark, x_breaks = x_breaks)
  }
}

ger_export_yoy_change <- function(y_axis, caption, decimal_mark = ",")
  .ger_trade_yoy("WERTA", "export_yoy", y_axis, caption, decimal_mark,
                 show_trend  = TRUE,
                 x_breaks    = "1 year",
                 start_date  = as.Date("2020-01-01"))

ger_import_yoy_change <- function(y_axis, caption, decimal_mark = ",")
  .ger_trade_yoy("WERTE", "import_yoy", y_axis, caption, decimal_mark)
