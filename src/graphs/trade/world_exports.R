trade_world_exports <- function(y_axis, caption, decimal_mark = ".", big_mark = ",") {
  dat <- with_cache(paste0("wdi_NE.EXP.GNFS.KD_1W_", DATA_START_YEAR),
                    fetch_wdi("NE.EXP.GNFS.KD", country = "1W")) |>
    dplyr::mutate(value = value / 1e9) |>
    dplyr::arrange(date)
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark)
}
