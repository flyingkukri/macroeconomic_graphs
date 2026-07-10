.choropleth_world_theme <- function() {
  ggplot2::theme(
    legend.position      = c(0.02, 0.02),
    legend.justification = c(0, 0),
    legend.key.height    = ggplot2::unit(1.5, "cm"),
    legend.text          = ggplot2::element_text(size = 9),
    legend.title         = ggplot2::element_text(size = 10, colour = hwwi_dark_grey, face = "bold"),
    legend.background    = ggplot2::element_rect(fill = "white", colour = NA),
    plot.caption         = ggplot2::element_text(hjust = 0, margin = ggplot2::margin(t = 10))
  )
}

plot_choropleth_world <- function(dat, fill_col = "value", legend_title = "",
                                   caption = "", low = "white", high = hwwi_blue,
                                   xlim = c(-179, 179), ylim = c(-56, 85)) {
  world  <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
  dat_sf <- dplyr::left_join(world, dat, by = c("iso_a3_eh" = "geo")) |> sf::st_as_sf()
  fill_max <- max(dat[[fill_col]], na.rm = TRUE)

  ggplot2::ggplot() +
    ggplot2::geom_sf(data = dat_sf, ggplot2::aes(fill = .data[[fill_col]]),
                     na.rm = TRUE, colour = NA) +
    ggplot2::geom_sf(data = world, fill = NA, linewidth = 0.2, colour = "grey70") +
    ggplot2::scale_fill_gradient(low = low, high = high, na.value = "grey88",
                                  trans = "sqrt", limits = c(0, fill_max)) +
    ggplot2::coord_sf(xlim = xlim, ylim = ylim, expand = FALSE) +
    ggplot2::labs(fill = legend_title, caption = paste0(caption, " ", format(Sys.Date(), "%Y"))) +
    hwwi_theme(no_axes = TRUE) +
    .choropleth_world_theme()
}

plot_choropleth_world_div <- function(dat, fill_col = "value", legend_title = "",
                                       caption = "", xlim = c(-179, 179), ylim = c(-56, 85)) {
  world   <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
  dat_sf  <- dplyr::left_join(world, dat, by = c("iso_a3_eh" = "geo")) |> sf::st_as_sf()
  abs_max <- max(abs(dat[[fill_col]]), na.rm = TRUE)

  ggplot2::ggplot() +
    ggplot2::geom_sf(data = dat_sf, ggplot2::aes(fill = .data[[fill_col]]),
                     na.rm = TRUE, colour = NA) +
    ggplot2::geom_sf(data = world, fill = NA, linewidth = 0.2, colour = "grey70") +
    ggplot2::scale_fill_gradient2(low = hwwi_rubin, mid = "white", high = hwwi_blue,
                                   midpoint = 0, na.value = "grey88",
                                   limits = c(-abs_max, abs_max)) +
    ggplot2::coord_sf(xlim = xlim, ylim = ylim, expand = FALSE) +
    ggplot2::labs(fill = legend_title, caption = paste0(caption, " ", format(Sys.Date(), "%Y"))) +
    hwwi_theme(no_axes = TRUE) +
    .choropleth_world_theme()
}

plot_choropleth_ger <- function(dat, fill_col = "value", legend_title = "",
                                  caption = "", low = hwwi_rubin, high = hwwi_dark_rubin) {
  states     <- rnaturalearth::ne_states(country = "germany", returnclass = "sf")
  lbl_pts    <- sf::st_point_on_surface(states)
  dat_sf     <- dplyr::left_join(dat, states[, c("name", "geometry")],
                                  by = c("geo" = "name")) |> sf::st_as_sf()
  fill_min   <- min(dat[[fill_col]], na.rm = TRUE)
  fill_max   <- max(dat[[fill_col]], na.rm = TRUE)

  ggplot2::ggplot() +
    ggplot2::geom_sf(data = dat_sf, ggplot2::aes(fill = .data[[fill_col]]),
                     na.rm = TRUE, colour = NA) +
    ggplot2::geom_sf(data = states, fill = NA, linewidth = 0.2) +
    ggrepel::geom_label_repel(
      data = lbl_pts,
      ggplot2::aes(x = sf::st_coordinates(lbl_pts)[, 1],
                   y = sf::st_coordinates(lbl_pts)[, 2], label = name),
      fill = "white", color = "black", size = 3,
      box.padding = 0.3, segment.color = "grey50"
    ) +
    ggplot2::scale_fill_gradient(low = low, high = high, na.value = NA,
                                  limits = c(fill_min, fill_max)) +
    ggplot2::labs(fill = legend_title, caption = paste0(caption, " ", format(Sys.Date(), "%Y"))) +
    hwwi_theme(no_axes = TRUE) +
    ggplot2::theme(legend.position = "right",
                   legend.text  = ggplot2::element_text(size = 9),
                   legend.title = ggplot2::element_text(size = 12))
}
