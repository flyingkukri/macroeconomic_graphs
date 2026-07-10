# World choropleth maps for trade by destination/origin country.
# Hamburg/LS exports: fetch_trade_by_country; imports: fetch_trade_by_country_import.
# Germany: fetch_ger_trade_by_country with direction argument.

trade_export_hamburg_country <- function(legend_title, caption, year = "2025") {
  dat <- with_cache(paste0("genesis_hh_exports_by_country_", year),
                    fetch_trade_by_country(as.integer(year), regional_key = "02"))
  plot_choropleth_world(dat, fill_col = "value", legend_title = legend_title, caption = caption)
}

trade_import_hamburg_country <- function(legend_title, caption, year = "2025") {
  dat <- with_cache(paste0("genesis_hh_imports_by_country_", year),
                    fetch_trade_by_country_import(as.integer(year), regional_key = "02"))
  plot_choropleth_world(dat, fill_col = "value", legend_title = legend_title, caption = caption)
}

trade_export_lowersaxony_country <- function(legend_title, caption, year = "2025") {
  dat <- with_cache(paste0("genesis_ls_exports_by_country_", year),
                    fetch_trade_by_country(as.integer(year), regional_key = "03"))
  plot_choropleth_world(dat, fill_col = "value", legend_title = legend_title, caption = caption)
}

trade_import_lowersaxony_country <- function(legend_title, caption, year = "2025") {
  dat <- with_cache(paste0("genesis_ls_imports_by_country_", year),
                    fetch_trade_by_country_import(as.integer(year), regional_key = "03"))
  plot_choropleth_world(dat, fill_col = "value", legend_title = legend_title, caption = caption)
}

trade_export_germany_country <- function(legend_title, caption, year = "2025") {
  dat <- with_cache(paste0("genesis_ger_exports_by_country_", year),
                    fetch_ger_trade_by_country(as.integer(year), direction = "export"))
  plot_choropleth_world(dat, fill_col = "value", legend_title = legend_title, caption = caption)
}

trade_import_germany_country <- function(legend_title, caption, year = "2025") {
  dat <- with_cache(paste0("genesis_ger_imports_by_country_", year),
                    fetch_ger_trade_by_country(as.integer(year), direction = "import"))
  plot_choropleth_world(dat, fill_col = "value", legend_title = legend_title, caption = caption)
}
