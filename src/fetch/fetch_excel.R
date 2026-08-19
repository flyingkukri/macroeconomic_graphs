fetch_excel <- function(path, sheet = 1, date_col, value_col,
                         series_name = "value", unit = NA_character_,
                         geo = NA_character_, date_format = "%Y-%m-%d", skip = 0) {
  raw <- readxl::read_excel(path, sheet = sheet, skip = skip)
  tibble::tibble(
    date   = as.Date(as.character(raw[[date_col]]), format = date_format),
    value  = as.numeric(raw[[value_col]]),
    series = series_name,
    unit   = unit,
    geo    = geo
  )
}