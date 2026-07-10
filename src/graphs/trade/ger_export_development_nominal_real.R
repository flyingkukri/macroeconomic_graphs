# Nominal vs real export/import development (annual bar, two series).
# Nominal from GENESIS 51000-0001; real from 81000-0027.

.ger_trade_nominal_real_bar <- function(nom_var, real_var, y_axis, caption, labels, decimal_mark) {
  raw_nom <- with_cache(paste0("genesis_51000-0001_", DATA_START_YEAR),
                         genesis_fetch("51000-0001"))
  nom <- parse_genesis(raw_nom, value_var = nom_var,
                        series_name = "Nominal", unit = "Mrd. EUR", geo = "DEU",
                        scale = 1 / 1e6) |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))

  raw_real <- with_cache(paste0("genesis_81000-0027_", DATA_START_YEAR),
                          genesis_fetch("81000-0027"))
  real <- parse_genesis(raw_real, value_var = real_var,
                         series_name = "Real", unit = "Mrd. EUR", geo = "DEU") |>
    dplyr::mutate(year = as.integer(format(date, "%Y")))

  dat <- dplyr::bind_rows(nom, real) |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_bar(dat, y_axis = y_axis, caption = caption, labels = labels,
            decimal_mark = decimal_mark, x_col = "year", y_col = "value",
            group_col = "series")
}

ger_export_development_nominal_real <- function(y_axis, caption, labels = NULL,
                                                   decimal_mark = ",")
  .ger_trade_nominal_real_bar("WERTA", "EXP001", y_axis, caption, labels, decimal_mark)

ger_import_development_nominal_real <- function(y_axis, caption, labels = NULL,
                                                   decimal_mark = ",")
  .ger_trade_nominal_real_bar("WERTE", "IMP001", y_axis, caption, labels, decimal_mark)
