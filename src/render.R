render_graph <- function(plot, title, out_dir, format = OUT_FORMAT,
                         width = OUT_WIDTH, height = OUT_HEIGHT, dpi = OUT_DPI) {
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
