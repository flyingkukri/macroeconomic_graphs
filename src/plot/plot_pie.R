plot_pie <- function(dat, group_col = "Group", value_col = "GerExport",
                      caption = "", big_mark = ".", decimal_mark = ",",
                      colors = NULL,
                      n_inside    = 1,        # largest n slices get white interior labels
                      inside_x    = 1.8,      # x position for inside labels
                      text_size   = 3.1,
                      start_angle = pi / 5,
                      x_limit     = 5.2,
                      plot_margin = ggplot2::margin(-70, 200, -20, -20)) {

  dat <- dat |>
    dplyr::arrange(.data[[value_col]]) |>
    dplyr::mutate(
      pct  = .data[[value_col]] / sum(.data[[value_col]], na.rm = TRUE) * 100,
      ymax = cumsum(.data[[value_col]]),
      ymin = dplyr::lag(ymax, default = 0),
      mid  = (ymax + ymin) / 2
    )

  n <- nrow(dat)
  if (is.null(colors)) {
    colors <- c(rep(c(hwwi_dark_blue, hwwi_blue, hwwi_light_blue), length.out = n - 1),
                hwwi_dark_blue)
  }
  dat$fill_color <- colors

  dat <- dat |>
    dplyr::mutate(
      label = paste0(
        .data[[group_col]], "\n",
        formatC(.data[[value_col]], big.mark = big_mark, format = "f", digits = 3),
        " Mrd.€ (", formatC(pct, format = "f", decimal.mark = decimal_mark, digits = 2), " %)"
      ),
      is_inside   = dplyr::row_number() > (dplyr::n() - n_inside),
      label_x     = ifelse(is_inside, inside_x, 4.3),
      label_hjust = ifelse(is_inside, 0.5, 0),
      label_color = ifelse(is_inside, "white", "black")
    )

  full_caption <- paste0(caption, " ", format(Sys.Date(), "%Y"))

  pie <- ggplot2::ggplot(dat, ggplot2::aes(ymin = ymin, ymax = ymax, xmin = 0, xmax = 4,
                                            fill = I(fill_color))) +
    ggplot2::geom_rect(color = "white") +
    ggplot2::coord_polar(theta = "y", start = start_angle, clip = "off") +
    ggplot2::xlim(c(0, x_limit)) +
    ggplot2::theme_void() +
    ggplot2::geom_text(
      ggplot2::aes(x = label_x, y = mid, label = label, hjust = label_hjust),
      color      = dat$label_color,
      size       = text_size,
      lineheight = 0.70
    ) +
    ggplot2::labs(caption = full_caption) +
    ggplot2::theme(
      plot.margin  = plot_margin,
      plot.caption = ggplot2::element_text(hjust = 0.5, vjust = 4, size = 10),
      legend.position = "none"
    )

  grob <- ggplot2::ggplotGrob(pie)
  grob$layout$clip[grob$layout$name == "panel"] <- "off"
  grob
}
