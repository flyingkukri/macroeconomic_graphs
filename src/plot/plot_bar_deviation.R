plot_bar_deviation <- function(dat, caption,
                                label_col       = "Group",
                                value_col       = "diff",
                                x_axis          = "",
                                decimal_mark    = ".",
                                big_mark        = ",",
                                positive_label  = "Above average",
                                negative_label  = "Below average",
                                colors          = c(hwwi_blue, hwwi_rubin)) {
  dat <- dat[order(dat[[value_col]]), ]
  dat[[label_col]] <- factor(dat[[label_col]], levels = dat[[label_col]])
  dat$direction <- ifelse(dat[[value_col]] >= 0, positive_label, negative_label)
  dat$direction <- factor(dat$direction, levels = c(positive_label, negative_label))

  ggplot2::ggplot(dat, ggplot2::aes(x = .data[[value_col]],
                                     y = .data[[label_col]],
                                     fill = direction)) +
    ggplot2::geom_col() +
    ggplot2::geom_vline(xintercept = 0, linewidth = 0.5, color = "grey40") +
    ggplot2::scale_fill_manual(
      values = setNames(colors, c(positive_label, negative_label)),
      guide  = ggplot2::guide_legend(title = "")
    ) +
    ggplot2::scale_x_continuous(
      labels = function(x) format(x, big.mark = big_mark,
                                   decimal.mark = decimal_mark, scientific = FALSE)
    ) +
    ggplot2::labs(x = x_axis, y = "", caption = paste0(caption, " ", format(Sys.Date(), "%Y"))) +
    hwwi_theme() +
    ggplot2::theme(legend.position = "bottom")
}
