# Deviation charts: state trade structure vs. Germany, by commodity group or country.
# Three visualization types: group bar, country bar (top5/bottom5), world choropleth.

# ── private helpers ────────────────────────────────────────────────────────────

.deviation_group_bar <- function(state_key, direction, caption, year,
                                  positive_label, negative_label, decimal_mark) {
  yr   <- if (is.null(year)) as.integer(format(Sys.Date(), "%Y")) - 1 else as.integer(year)
  comp <- fetch_state_deviation(yr, state_key = state_key, direction = direction)
  comp <- comp[order(-comp$diff), ]
  comp <- rbind(head(comp, 5), tail(comp, 5))
  plot_bar_deviation(comp, caption = caption, label_col = "Group", value_col = "diff",
                      x_axis = if (decimal_mark == ",") "Prozentpunkte" else "Percentage points",
                      decimal_mark = decimal_mark,
                      positive_label = positive_label, negative_label = negative_label)
}

.deviation_country_bar <- function(state_key, state_label, direction, caption, year,
                                    positive_label, negative_label, decimal_mark) {
  yr  <- if (is.null(year)) as.integer(format(Sys.Date(), "%Y")) - 1 else as.integer(year)
  dat <- with_cache(paste0("genesis_", state_label, "_", direction, "_dev_country_", yr),
                    fetch_trade_share_deviation_by_country(yr, regional_key = state_key,
                                                            direction = direction))
  dat <- dat[!is.na(dat$value), ]
  dat$Country <- countrycode::countrycode(dat$geo, "iso3c", "country.name", warn = FALSE)
  dat <- dat[!is.na(dat$Country), ]
  comp <- rbind(head(dat[order(-dat$value), ], 5), tail(dat[order(-dat$value), ], 5))
  plot_bar_deviation(comp, caption = caption, label_col = "Country", value_col = "value",
                      x_axis = if (decimal_mark == ",") "Prozentpunkte" else "Percentage points",
                      decimal_mark = decimal_mark,
                      positive_label = positive_label, negative_label = negative_label)
}

.deviation_country_choropleth <- function(state_key, state_label, direction,
                                           caption, year, legend_title) {
  yr  <- if (is.null(year)) as.integer(format(Sys.Date(), "%Y")) - 1 else as.integer(year)
  dat <- with_cache(paste0("genesis_", state_label, "_", direction, "_dev_country_", yr),
                    fetch_trade_share_deviation_by_country(yr, regional_key = state_key,
                                                            direction = direction))
  plot_choropleth_world_div(dat, fill_col = "value", legend_title = legend_title,
                             caption = caption)
}

# ── commodity-group deviation bars (HH and LS) ────────────────────────────────

trade_hh_export_deviation_group <- function(caption, year = NULL,
                                              positive_label = "HH > Deutschland",
                                              negative_label = "HH < Deutschland",
                                              decimal_mark = ",")
  .deviation_group_bar("02", "export", caption, year, positive_label, negative_label, decimal_mark)

trade_hh_import_deviation_group <- function(caption, year = NULL,
                                              positive_label = "HH > Deutschland",
                                              negative_label = "HH < Deutschland",
                                              decimal_mark = ",")
  .deviation_group_bar("02", "import", caption, year, positive_label, negative_label, decimal_mark)

trade_ls_export_deviation_group <- function(caption, year = NULL,
                                              positive_label = "LS > Deutschland",
                                              negative_label = "LS < Deutschland",
                                              decimal_mark = ",")
  .deviation_group_bar("03", "export", caption, year, positive_label, negative_label, decimal_mark)

trade_ls_import_deviation_group <- function(caption, year = NULL,
                                              positive_label = "LS > Deutschland",
                                              negative_label = "LS < Deutschland",
                                              decimal_mark = ",")
  .deviation_group_bar("03", "import", caption, year, positive_label, negative_label, decimal_mark)

# Aliases used in registry for group-level deviation bar (identical computation).
hh_export_deviation_country_map <- function(caption, year = NULL,
                                              positive_label = "HH > Deutschland",
                                              negative_label = "HH < Deutschland",
                                              decimal_mark = ",")
  .deviation_group_bar("02", "export", caption, year, positive_label, negative_label, decimal_mark)

hh_import_deviation_country_map <- function(caption, year = NULL,
                                              positive_label = "HH > Deutschland",
                                              negative_label = "HH < Deutschland",
                                              decimal_mark = ",")
  .deviation_group_bar("02", "import", caption, year, positive_label, negative_label, decimal_mark)

# ── country deviation bars (HH and LS) ────────────────────────────────────────

hh_export_deviation_country <- function(caption, year = NULL,
                                          positive_label = "HH > Deutschland",
                                          negative_label = "HH < Deutschland",
                                          decimal_mark = ",")
  .deviation_country_bar("02", "hh", "export", caption, year,
                          positive_label, negative_label, decimal_mark)

hh_import_deviation_country <- function(caption, year = NULL,
                                          positive_label = "HH > Deutschland",
                                          negative_label = "HH < Deutschland",
                                          decimal_mark = ",")
  .deviation_country_bar("02", "hh", "import", caption, year,
                          positive_label, negative_label, decimal_mark)

ls_export_deviation_country <- function(caption, year = NULL,
                                          positive_label = "LS > Deutschland",
                                          negative_label = "LS < Deutschland",
                                          decimal_mark = ",")
  .deviation_country_bar("03", "ls", "export", caption, year,
                          positive_label, negative_label, decimal_mark)

ls_import_deviation_country <- function(caption, year = NULL,
                                          positive_label = "LS > Deutschland",
                                          negative_label = "LS < Deutschland",
                                          decimal_mark = ",")
  .deviation_country_bar("03", "ls", "import", caption, year,
                          positive_label, negative_label, decimal_mark)

# Top-5 / bottom-5 country variants (same computation, explicit year default).
trade_hh_export_topbottom_country <- function(caption, year = "2025",
                                                positive_label = "HH > Deutschland",
                                                negative_label = "HH < Deutschland",
                                                decimal_mark = ",")
  .deviation_country_bar("02", "hh", "export", caption, year,
                          positive_label, negative_label, decimal_mark)

trade_hh_import_topbottom_country <- function(caption, year = "2025",
                                                positive_label = "HH > Deutschland",
                                                negative_label = "HH < Deutschland",
                                                decimal_mark = ",")
  .deviation_country_bar("02", "hh", "import", caption, year,
                          positive_label, negative_label, decimal_mark)

trade_ls_export_topbottom_country <- function(caption, year = "2025",
                                                positive_label = "LS > Deutschland",
                                                negative_label = "LS < Deutschland",
                                                decimal_mark = ",")
  .deviation_country_bar("03", "ls", "export", caption, year,
                          positive_label, negative_label, decimal_mark)

trade_ls_import_topbottom_country <- function(caption, year = "2025",
                                                positive_label = "LS > Deutschland",
                                                negative_label = "LS < Deutschland",
                                                decimal_mark = ",")
  .deviation_country_bar("03", "ls", "import", caption, year,
                          positive_label, negative_label, decimal_mark)

# ── country deviation choropleths ──────────────────────────────────────────────

hh_export_deviation_choropleth <- function(legend_title, caption, year = NULL)
  .deviation_country_choropleth("02", "hh", "export", caption, year, legend_title)

hh_import_deviation_choropleth <- function(legend_title, caption, year = NULL)
  .deviation_country_choropleth("02", "hh", "import", caption, year, legend_title)

ls_export_deviation_choropleth <- function(legend_title, caption, year = NULL)
  .deviation_country_choropleth("03", "ls", "export", caption, year, legend_title)

ls_import_deviation_choropleth <- function(legend_title, caption, year = NULL)
  .deviation_country_choropleth("03", "ls", "import", caption, year, legend_title)
