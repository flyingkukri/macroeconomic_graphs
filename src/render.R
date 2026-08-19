.render_language_from_dir <- function(out_dir) {
  path <- tolower(gsub("\\\\", "/", out_dir))
  if (grepl("german labeling", path, fixed = TRUE)) return("de")
  if (grepl("english labeling", path, fixed = TRUE)) return("en")
  NA_character_
}

.filter_frame_from_year <- function(dat, start_year) {
  if (!is.data.frame(dat) || !"date" %in% names(dat)) return(dat)
  if (!inherits(dat$date, c("Date", "POSIXct", "POSIXt"))) return(dat)

  cutoff <- as.Date(sprintf("%d-01-01", start_year))
  keep <- is.na(dat$date) | as.Date(dat$date) >= cutoff
  dat[keep, , drop = FALSE]
}

# Enforce --start-year at the final rendering boundary. Most graph modules
# already filter their source data, but this also covers older modules with a
# hard-coded historical start and custom plots that keep data on their layers.
.apply_render_start_year <- function(plot) {
  start_year <- getOption("hwwi.start.year")
  if (is.null(start_year) || !inherits(plot, "ggplot")) return(plot)

  plot$data <- .filter_frame_from_year(plot$data, start_year)
  for (i in seq_along(plot$layers)) {
    plot$layers[[i]]$data <- .filter_frame_from_year(plot$layers[[i]]$data, start_year)
  }
  plot
}

render_graph <- function(plot, title, out_dir, format = OUT_FORMAT,
                         width = OUT_WIDTH, height = OUT_HEIGHT, dpi = OUT_DPI) {
  requested_language <- getOption("hwwi.render.language")
  output_language <- .render_language_from_dir(out_dir)

  # `plot` is a lazy argument. Returning before it is evaluated means that a
  # one-language run does not fetch data or build the unrequested variant.
  if (!is.null(requested_language) && !is.na(output_language) &&
      !identical(requested_language, output_language)) {
    return(invisible(NULL))
  }

  output_override <- getOption("hwwi.output.dir")
  if (!is.null(output_override)) out_dir <- output_override

  plot <- .apply_render_start_year(plot)

  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  path <- file.path(out_dir, paste0(title, ".", format))
  ggplot2::ggsave(filename = path, plot = plot, width = width, height = height,
                  dpi = dpi, units = "in", bg = "white")
  invisible(path)
}

render_all <- function(specs_dir = "src/graphs", out_base = "Graphs",
                       format = "jpeg", width = 11, height = 6, dpi = 300) {
  spec_files <- list.files(specs_dir, pattern = "\\.R$", recursive = TRUE, full.names = TRUE)
  for (f in spec_files) source(f, local = new.env(parent = .GlobalEnv))
  message("Sourced ", length(spec_files), " spec files from ", specs_dir)
}
