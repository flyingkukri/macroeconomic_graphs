.render_language_from_dir <- function(out_dir) {
  path <- tolower(gsub("\\\\", "/", out_dir))
  if (grepl("german labeling", path, fixed = TRUE)) return("de")
  if (grepl("english labeling", path, fixed = TRUE)) return("en")
  NA_character_
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
