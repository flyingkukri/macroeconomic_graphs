yoy_growth <- function(dat, value_col = "value", lag_periods = 1) {
  dat |>
    dplyr::arrange(date) |>
    dplyr::mutate(
      !!value_col := (.data[[value_col]] / dplyr::lag(.data[[value_col]], lag_periods) - 1) * 100
    )
}
