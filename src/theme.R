if (!require("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
  tidyverse, sf, ggplot2, extrafont, patchwork,
  countrycode, scales, ggrepel, ggnewscale,
  rnaturalearth, rnaturalearthdata, WDI, readxl,
  httr, jsonlite, xml2
)

if ("Verdana" %in% extrafont::fonts()) suppressWarnings(extrafont::loadfonts(quiet = TRUE))

hwwi_light_blue <- "#B4CAE2"
hwwi_blue       <- "#004F9F"
hwwi_dark_blue  <- "#14387F"
hwwi_rubin      <- "#B80E80"
hwwi_dark_rubin <- "#810759"
hwwi_grey       <- "#D0D0D0"
hwwi_dark_grey  <- "#3C3C3C"

hwwi_palette    <- c(hwwi_blue, hwwi_rubin, hwwi_dark_blue, hwwi_dark_rubin, hwwi_light_blue, hwwi_grey, hwwi_dark_grey)
hwwi_palette_rb <- c(hwwi_dark_blue, hwwi_blue, hwwi_light_blue, hwwi_grey, hwwi_rubin, hwwi_dark_rubin)

hwwi_theme <- function(flip = FALSE, no_axes = FALSE, grid_xy = FALSE,
                       base_size = 13, base_family = "Verdana") {
  th <- ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      panel.grid.minor   = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(colour = "grey85", linewidth = 0.4),
      panel.grid.major.x = ggplot2::element_blank(),
      axis.line = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      axis.text  = ggplot2::element_text(colour = hwwi_dark_grey, face = "bold", size = base_size + 1),
      axis.title = ggplot2::element_text(colour = hwwi_dark_grey, face = "bold", size = base_size + 1),
      legend.position = "none",
      legend.title = ggplot2::element_text(colour = hwwi_dark_grey, face = "bold", size = base_size),
      legend.text  = ggplot2::element_text(colour = hwwi_dark_grey, face = "bold", size = base_size),
      plot.caption.position = "plot",
      plot.caption  = ggplot2::element_text(hjust = 1, colour = hwwi_dark_grey, size = base_size - 3),
      plot.title.position = "plot",
      plot.title    = ggplot2::element_text(colour = hwwi_dark_grey, face = "bold", size = base_size + 3),
      plot.subtitle = ggplot2::element_text(colour = hwwi_dark_grey, size = base_size)
    )
  if (grid_xy) th <- th + ggplot2::theme(panel.grid.major.x = ggplot2::element_line(colour = "grey85", linewidth = 0.4))
  if (flip)    th <- th + ggplot2::theme(panel.grid.major.y = ggplot2::element_blank(),
                                          panel.grid.major.x = ggplot2::element_line(colour = "grey85", linewidth = 0.4))
  if (no_axes) th <- th + ggplot2::theme(axis.title = ggplot2::element_blank(),
                                          axis.text  = ggplot2::element_blank(),
                                          panel.grid = ggplot2::element_blank())
  th
}
