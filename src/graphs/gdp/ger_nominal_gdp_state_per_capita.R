# Nominal GDP per capita for German Bundesländer — bar chart and choropleth map.
# Source: Statistische Ämter des Bundes und der Länder (local CSV).

.read_gdp_state_per_capita <- function() {
  csv_path <- file.path("R scripts", "Functions GDP graphs",
                        "wirtschaftsleistung-bundeslaender-2024.csv")
  raw <- utils::read.csv2(csv_path, fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)
  colnames(raw) <- c("geo", "value")
  exclude <- c("Westliche Bundesländer", "Östliche Bundesländer", "Deutschland")
  dat <- raw[!raw$geo %in% exclude, , drop = FALSE]
  dat$value <- as.numeric(dat$value)
  dat[!is.na(dat$value) & !is.na(dat$geo), ]
}

ger_nominal_gdp_state_per_capita <- function(y_axis, caption,
                                              decimal_mark = ",", big_mark = ".") {
  dat    <- .read_gdp_state_per_capita()
  dat    <- dat[order(dat$value, decreasing = TRUE), ]
  y_high <- ceiling(max(dat$value, na.rm = TRUE) / 10000) * 10000
  ggplot2::ggplot(dat, ggplot2::aes(x = factor(geo, levels = dat$geo), y = value)) +
    ggplot2::geom_col(fill = hwwi_blue, width = 0.8) +
    ggplot2::scale_y_continuous(
      limits = c(0, y_high),
      breaks = seq(0, y_high, by = 10000),
      labels = function(x) format(x, big.mark = big_mark,
                                   decimal.mark = decimal_mark, scientific = FALSE)
    ) +
    ggplot2::labs(x = "", y = y_axis, caption = caption) +
    hwwi_theme() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust = 1))
}

ger_nominal_gdp_state_per_capita_map <- function(legend_title, caption) {
  dat <- .read_gdp_state_per_capita()
  plot_choropleth_ger(dat, fill_col = "value",
                      legend_title = legend_title, caption = caption,
                      low = "white", high = hwwi_rubin)
}
