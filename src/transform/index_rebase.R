rebase_index <- function(dat, base_year, value_col = "value") {
  base_val <- dat |>
    dplyr::filter(format(date, "%Y") == as.character(base_year)) |>
    dplyr::summarise(m = mean(.data[[value_col]], na.rm = TRUE)) |>
    dplyr::pull(m)
  dplyr::mutate(dat, !!value_col := .data[[value_col]] / base_val * 100)
}
