# Adding a New Graph
Extending the graphs library requires two steps. First, using the predefined building blocks, give a code specification of the graph to be created. 
Afterwards, add the metadata of the graph to the bottom of the file.

The code specification is divided into three stages: 
1. Fetch the data
2. Transform the data as necessary
3. Plot it using one of the predefined plotting helpers

For each stage, this library includes predefined helper functions to simplify the flow.
Section 0 will show an example graph and explain the components, while the latter sections serve as a reference for the helper functions for each part of the plot generation. 

## 0. Example Graph
```r
# Create a helper function that captures the graph logic
.ger_gdp_state_growth_helper <- function() {
  # 1. Fetch the raw data
  raw <- with_cache(
    paste0("genesis_82111-0010_", DATA_START_YEAR),     
    genesis_fetch("82111-0010", start_year = DATA_START_YEAR)
  )

  # 1.1 Extract the correct columns from the data
  rows <- raw[
    !is.na(raw$value_variable_code) & raw$value_variable_code == "BIP006" &
      !is.na(raw$value) & !raw$value %in% c("-", "/", ".", "", "..."),
    , drop = FALSE
  ]
  dat <- tibble::tibble(
      date   = as.Date(paste0(rows$time, "-01-01")),
      value  = as.numeric(gsub(",", ".", rows$value)),
      series = "state_gdp_nominal",
      unit   = "Mill. EUR",
      geo    = rows[["1_variable_attribute_label"]]
    )

  # 2. Transform the data into yoy growth 
  dat |>
    dplyr::group_by(geo) |>
    dplyr::group_modify(~ yoy_growth(.x, value_col = "value")) |>
    dplyr::ungroup() |>
    dplyr::filter(!is.na(value), date == max(date)) |>
    dplyr::arrange(value)  # latest year's growth, one bar per state
}

# Return the final plot function. 
ger_nominal_gdp_state_growth <- function(y_axis, caption, decimal_mark = ",", big_mark = ".") {
  dat <- .ger_gdp_state_growth_helper()
  # 3. Choose the plot type
  plot_bar_ranking(dat, caption = caption, label_col = "geo", value_col = "value",
                    x_axis = y_axis, decimal_mark = decimal_mark, big_mark = big_mark)
}

# 4. Add metadata for the graph.  
.graph_specs <- list(
list(id = "ger_nominal_gdp_state_growth", category = "GDP", label = "Germany nominal GDP growth by state (YoY %, ranking)",
    render = function() {
        GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
        EN <- file.path(OUT_DIR, "GDP graphs/English labeling")
        render_graph(ger_nominal_gdp_state_growth("Veränderung ggü. Vorjahr in %", "Datenquelle: Statistisches Bundesamt (Destatis)"),
            "GER nominal GDP growth by state_ger", GER)
        render_graph(ger_nominal_gdp_state_growth("YoY change in %", "Data source: Federal statistical office (Destatis)",
            decimal_mark = ".", big_mark = ","), "GER nominal GDP growth by state_en", EN)
    })
)

# Boilerplate code for debugging
if (!exists("auto_run_graph_file", mode = "function")) source("src/graph_modules.R")
auto_run_graph_file("src/graphs/gdp/ger_nominal_gdp_state_growth.R", .graph_specs)
```

## 1. Retrieving and Parsing the Data

Most data source adapters in `src/fetch/` return the same tibble shape:

```
tibble(date, value, series, unit, geo)
```


### `genesis_fetch()`

```r
genesis_fetch(table_key, start_year = DATA_START_YEAR, end_year = 2100, ...)
```

Downloads a raw table from Destatis GENESIS using `restatis::gen_table()`.

Parameters:

- `table_key`: GENESIS table identifier, such as `"81000-0001"`.
- `start_year`: First year to request. Defaults to `DATA_START_YEAR`.
- `end_year`: Last year to request. Defaults to `2100`, allowing GENESIS to return all currently available observations.
- `...`: Additional filters passed to `restatis::gen_table()`, such as `regionalvariable`, `regionalkey`, `classifyingvariable1`, or `classifyingkey1`.

Returns the raw long-format table supplied by GENESIS. Find table identifiers through the [GENESIS-Online](https://www-genesis.destatis.de) catalog.

### `parse_genesis()`

```r
parse_genesis(
  raw,
  value_var,
  series_name = "value",
  unit = NA_character_,
  geo = "DEU",
  class_filters = NULL,
  unit_filter = NULL,
  scale = 1
)
```

Filters a raw GENESIS result and converts it to `tibble(date, value, series, unit, geo)`.

Parameters:

- `raw`: Table returned by `genesis_fetch()`.
- `value_var`: Value-variable code to retain, such as `"BIP005"`. Inspect `unique(raw$value_variable_code)` to find available codes.
- `series_name`: Constant value written to the output `series` column.
- `unit`: Constant output unit. If `NA`, the first matching GENESIS unit is used.
- `geo`: Constant value written to the output `geo` column. This does not extract changing geographic labels from `raw`.
- `class_filters`: Named list of additional column/value filters, for example `list("2_variable_attribute_code" = "DG")`.
- `unit_filter`: Optional GENESIS unit to retain before parsing, such as `"2020=100"`.
- `scale`: Multiplier applied to every parsed value, for example `1 / 1e6` to convert thousand euros to billion euros.

Returns a tibble in the standard shape.

### `fetch_wdi()`

```r
fetch_wdi(
  indicator,
  country,
  start = DATA_START_YEAR,
  end = as.integer(format(Sys.Date(), "%Y"))
)
```

Downloads an annual indicator from the World Bank WDI API and converts it to the standard shape.

Parameters:

- `indicator`: WDI indicator code, such as `"NY.GDP.PCAP.PP.KD"`.
- `country`: ISO3C country code, WDI aggregate code such as `"1W"`, or a vector of codes.
- `start`: First year to request.
- `end`: Last year to request. Defaults to the current year.

Returns `tibble(date, value, series, unit, geo)`.

### `fetch_bundesbank_series()`

```r
fetch_bundesbank_series(dataset, key)
```

Downloads one series directly from the Bundesbank SDMX REST API.

Parameters:

- `dataset`: Bundesbank SDMX dataset identifier.
- `key`: Series key within the dataset.

Returns `tibble(date, value)`. Add `series`, `unit`, and `geo` columns if the selected plot builder requires them.

### `fetch_excel()`

```r
fetch_excel(
  path,
  sheet = 1,
  date_col,
  value_col,
  series_name = "value",
  unit = NA_character_,
  geo = NA_character_,
  date_format = "%Y-%m-%d",
  skip = 0
)
```

Reads one date/value series from a local Excel worksheet and converts it to the standard shape.

Parameters:

- `path`: Path to the Excel workbook.
- `sheet`: Sheet name or number. Defaults to the first sheet.
- `date_col`: Name or position of the column containing dates.
- `value_col`: Name or position of the column containing values.
- `series_name`: Constant value written to the output `series` column.
- `unit`: Constant value written to the output `unit` column.
- `geo`: Constant value written to the output `geo` column.
- `date_format`: Format used to parse character dates.
- `skip`: Number of rows to skip before reading the worksheet.

Returns `tibble(date, value, series, unit, geo)`.

If none of these fit, add a new `src/fetch/fetch_<source>.R` file with a function that returns the same `date, value, series, unit, geo` shape, and source it from [src/bootstrap.R](src/bootstrap.R).

Trade graphs also have higher-level domain fetchers in `fetch_genesis.R` (`fetch_hh_trade()`, `fetch_ger_trade_by_country()`, `fetch_state_deviation()`, etc.) worth checking before writing raw GENESIS calls from scratch.

## 2. Cache the raw fetch

### `with_cache()`

```r
with_cache(key, expr, cache_dir = CACHE_DIR)
```

Returns a saved result when one exists; otherwise, evaluates the expression and saves its result as an RDS file.

Parameters:

- `key`: Unique cache identifier. Include every fetch parameter that changes the result.
- `expr`: Fetch expression to evaluate on a cache miss. R's lazy evaluation prevents it from running on a cache hit.
- `cache_dir`: Directory containing the RDS cache files. Defaults to `CACHE_DIR`.

Include `DATA_START_YEAR` in `key` whenever the fetch depends on it. This ensures that the `--start-year=YYYY` CLI option selects a separate cache entry (see [CLAUDE.md](CLAUDE.md#--start-year-override)):

```r
raw <- with_cache(paste0("genesis_81000-0001_", DATA_START_YEAR),
                  genesis_fetch("81000-0001"))
```

For snapshot-style data (a single year, e.g. trade-structure pies), key by that year instead:

```r
raw <- with_cache(paste0("genesis_51000-0005_", year), fetch_ger_trade_commodity(year))
```

## 3. Transform

`src/transform/` has three helpers:

### `yoy_growth()`

```r
yoy_growth(dat, value_col = "value", lag_periods = 1)
```

Replaces a value column with its percentage change from the selected lag.

Parameters:

- `dat`: Data frame containing `date` and the value column. For multiple series, group the data before calling this function.
- `value_col`: Name of the column to transform.
- `lag_periods`: Number of rows to lag after sorting by `date`. Use `1` for annual data and `12` for monthly year-over-year growth.

Returns `dat` with the selected value column expressed as percentage growth. The first `lag_periods` values are `NA`.

### `rebase_index()`

```r
rebase_index(dat, base_year, value_col = "value")
```

Rebases a series so that the mean observation in the selected year equals 100.

Parameters:

- `dat`: Data frame containing `date` and the value column.
- `base_year`: Calendar year to use as the index base.
- `value_col`: Name of the column to rebase.

Returns `dat` with the selected value column converted to the rebased index.

### `seasonal_adjust()`

```r
seasonal_adjust(dat)
```

Applies monthly X-13ARIMA-SEATS seasonal adjustment using the `seasonal` package.

Parameters:

- `dat`: Data frame containing a monthly `date` column and a numeric `value` column.

Returns the input data with `value` replaced by the adjusted series. It returns the unadjusted data if the package is unavailable or adjustment fails.

Most GENESIS tables already offer seasonally-adjusted or chain-indexed variants as a `class_filters` code (see the `ger_bip_*` specs), which is preferred over adjusting client-side.

## 4. Pick a plot builder

All builders are located in `src/plot/` and append the current year to `caption`. Most apply `hwwi_theme()` automatically; `plot_pie()` uses `ggplot2::theme_void()` with its own caption and margin styling.

### `plot_timeseries()`

```r
plot_timeseries(
  dat, y_axis, caption,
  decimal_mark = ".", big_mark = ",",
  color = hwwi_blue, x_breaks = "5 years",
  y_limits = NULL, y_breaks = ggplot2::waiver(), linewidth = 1.8
)
```

Creates a single-series line chart.

Parameters:

- `dat`: Data frame containing `date` and `value`.
- `y_axis`: Y-axis title.
- `caption`: Source caption.
- `decimal_mark`: Decimal separator used in value labels.
- `big_mark`: Thousands separator used in value labels.
- `color`: Line color.
- `x_breaks`: Date-break interval accepted by `ggplot2::scale_x_date()`.
- `y_limits`: Optional two-element vector of y-axis limits.
- `y_breaks`: Y-axis breaks or a ggplot2 waiver.
- `linewidth`: Width of the plotted line.

### `plot_timeseries_multi()`

```r
plot_timeseries_multi(
  dat, y_axis, caption, labels = NULL,
  decimal_mark = ".", big_mark = ",",
  colors = hwwi_palette, x_breaks = "5 years",
  y_limits = NULL, linewidth = 1.8
)
```

Creates a multiple-series line chart using the `series` column.

Parameters:

- `dat`: Data frame containing `date`, `value`, and `series`.
- `y_axis`: Y-axis title.
- `caption`: Source caption.
- `labels`: Optional legend labels in series order.
- `decimal_mark`: Decimal separator used in value labels.
- `big_mark`: Thousands separator used in value labels.
- `colors`: Vector of line colors.
- `x_breaks`: Date-break interval.
- `y_limits`: Optional two-element vector of y-axis limits.
- `linewidth`: Width of the plotted lines.

### `plot_bar_date()`

```r
plot_bar_date(
  dat, y_axis, caption, labels = NULL,
  decimal_mark = ".", big_mark = ",",
  colors = c(scales::alpha(hwwi_blue, 0.6), hwwi_rubin),
  x_breaks = "2 years", y_limits = NULL
)
```

Creates overlapping bars on a date axis using the `series` column. Set factor levels so the series that should appear behind is drawn first.

Parameters:

- `dat`: Data frame containing `date`, `value`, and `series`.
- `y_axis`: Y-axis title.
- `caption`: Source caption.
- `labels`: Optional legend labels in series order.
- `decimal_mark`: Decimal separator used in value labels.
- `big_mark`: Thousands separator used in value labels.
- `colors`: Fill colors in series order.
- `x_breaks`: Date-break interval.
- `y_limits`: Optional two-element vector of y-axis limits.

### `plot_bar_growth()`

```r
plot_bar_growth(
  dat, y_axis, caption,
  decimal_mark = ".", color = hwwi_blue, x_breaks = "2 years"
)
```

Creates annual growth bars with percentage labels.

Parameters:

- `dat`: Data frame containing `date` and percentage `value`.
- `y_axis`: Y-axis title.
- `caption`: Source caption.
- `decimal_mark`: Decimal separator used in percentage labels.
- `color`: Bar color.
- `x_breaks`: Date-break interval.

### `plot_bar()`

```r
plot_bar(
  dat, y_axis, caption, labels = NULL,
  decimal_mark = ".", x_col = "date", y_col = "value",
  group_col = "series",
  colors = c(alpha(hwwi_blue, 0.9), alpha(hwwi_rubin, 0.9)),
  y_limits = NULL, position = "dodge"
)
```

Creates grouped bars on a discrete numeric x-axis. Although the function's legacy default is `x_col = "date"`, its x scale is numeric: create a numeric column such as `year` and pass `x_col = "year"`, as the existing graph modules do.

Parameters:

- `dat`: Data frame containing the x, y, and grouping columns.
- `y_axis`: Y-axis title.
- `caption`: Source caption.
- `labels`: Optional legend labels in group order.
- `decimal_mark`: Decimal separator used in value labels.
- `x_col`: Name of the x-axis column.
- `y_col`: Name of the value column.
- `group_col`: Name of the fill-group column.
- `colors`: Fill colors in group order.
- `y_limits`: Optional two-element vector of y-axis limits.
- `position`: Bar-position adjustment, such as `"dodge"`, `"stack"`, or `"identity"`.

### `plot_bar_deviation()`

```r
plot_bar_deviation(
  dat, caption,
  label_col = "Group", value_col = "diff", x_axis = "",
  decimal_mark = ".", big_mark = ",",
  positive_label = "Above average", negative_label = "Below average",
  colors = c(hwwi_blue, hwwi_rubin)
)
```

Creates horizontal diverging bars around zero.

Parameters:

- `dat`: Data frame containing category labels and numeric deviations.
- `caption`: Source caption.
- `label_col`: Name of the category-label column.
- `value_col`: Name of the deviation column.
- `x_axis`: Numeric-axis title.
- `decimal_mark`: Decimal separator used in value labels.
- `big_mark`: Thousands separator used in value labels.
- `positive_label`: Legend label assigned to non-negative values.
- `negative_label`: Legend label assigned to negative values.
- `colors`: Colors for positive and negative bars, respectively.

### `plot_bar_ranking()`

```r
plot_bar_ranking(
  dat, caption,
  label_col = "name", value_col = "value", x_axis = "",
  decimal_mark = ".", big_mark = ",", color = hwwi_blue
)
```

Creates a horizontal ranking bar chart.

Parameters:

- `dat`: Data frame containing category labels and numeric values, ordered as they should appear in the ranking.
- `caption`: Source caption.
- `label_col`: Name of the category-label column.
- `value_col`: Name of the numeric value column.
- `x_axis`: Numeric-axis title.
- `decimal_mark`: Decimal separator used in value labels.
- `big_mark`: Thousands separator used in value labels.
- `color`: Bar color.

### `plot_dual_axis()`

```r
plot_dual_axis(
  dat, caption,
  y_axis_left, y_axis_right, series_left, series_right,
  decimal_mark = ".", big_mark = ",",
  colors = c(hwwi_blue, hwwi_rubin), x_breaks = "5 years",
  y_max_right = NULL, y_min_at_zero = TRUE
)
```

Creates two line series with different units on aligned left and right axes.

Parameters:

- `dat`: Data frame containing `date`, `value`, and `series`.
- `caption`: Source caption.
- `y_axis_left`: Left-axis title.
- `y_axis_right`: Right-axis title.
- `series_left`: Value in `series` assigned to the left axis.
- `series_right`: Value in `series` assigned to the right axis.
- `decimal_mark`: Decimal separator used on both axes.
- `big_mark`: Thousands separator used on both axes.
- `colors`: Colors for the left and right series, respectively.
- `x_breaks`: Date-break interval.
- `y_max_right`: Optional fixed maximum for the right axis.
- `y_min_at_zero`: Whether both axes should start at zero.

### `plot_pie()`

```r
plot_pie(
  dat, group_col = "Group", value_col = "GerExport",
  caption = "", big_mark = ".", decimal_mark = ",", colors = NULL,
  n_inside = 1, inside_x = 1.8, text_size = 3.1,
  start_angle = pi / 5, x_limit = 5.2,
  plot_margin = ggplot2::margin(-70, 200, -20, -20)
)
```

Creates a polar composition chart with value and percentage labels.

Parameters:

- `dat`: Data frame containing group labels and positive numeric values.
- `group_col`: Name of the slice-label column.
- `value_col`: Name of the slice-value column.
- `caption`: Source caption.
- `big_mark`: Thousands separator used in value labels.
- `decimal_mark`: Decimal separator used in percentage labels.
- `colors`: Optional vector of slice colors; the HWWI palette is generated when omitted.
- `n_inside`: Number of largest slices whose labels are placed inside the chart.
- `inside_x`: Radial position of inside labels.
- `text_size`: Label-text size.
- `start_angle`: Rotation in radians.
- `x_limit`: Radial plotting limit, including space for outside labels.
- `plot_margin`: ggplot2 margin around the chart.

### `plot_choropleth_world()`

```r
plot_choropleth_world(
  dat, fill_col = "value", legend_title = "", caption = "",
  low = "white", high = hwwi_blue,
  xlim = c(-179, 179), ylim = c(-56, 85)
)
```

Creates a world choropleth with a sequential square-root color scale.

Parameters:

- `dat`: Data frame whose `geo` column contains ISO3C country codes.
- `fill_col`: Name of the numeric fill column.
- `legend_title`: Fill-legend title.
- `caption`: Source caption.
- `low`: Color used at the low end of the scale.
- `high`: Color used at the high end of the scale.
- `xlim`: Longitude limits.
- `ylim`: Latitude limits.

### `plot_choropleth_world_div()`

```r
plot_choropleth_world_div(
  dat, fill_col = "value", legend_title = "", caption = "",
  xlim = c(-179, 179), ylim = c(-56, 85)
)
```

Creates a world choropleth with a zero-centered diverging color scale.

Parameters:

- `dat`: Data frame whose `geo` column contains ISO3C country codes.
- `fill_col`: Name of the numeric fill column.
- `legend_title`: Fill-legend title.
- `caption`: Source caption.
- `xlim`: Longitude limits.
- `ylim`: Latitude limits.

### `plot_choropleth_ger()`

```r
plot_choropleth_ger(
  dat, fill_col = "value", legend_title = "", caption = "",
  low = hwwi_rubin, high = hwwi_dark_rubin
)
```

Creates a choropleth of the German states.

Parameters:

- `dat`: Data frame whose `geo` column contains state names matching the map data.
- `fill_col`: Name of the numeric fill column.
- `legend_title`: Fill-legend title.
- `caption`: Source caption.
- `low`: Color used at the low end of the scale.
- `high`: Color used at the high end of the scale.

Brand colors (`hwwi_blue`, `hwwi_rubin`, `hwwi_dark_blue`, `hwwi_dark_rubin`, `hwwi_light_blue`, `hwwi_grey`, `hwwi_dark_grey`, and the `hwwi_palette`/`hwwi_palette_rb` vectors) are defined in [src/theme.R](src/theme.R) — reuse them rather than hardcoding new colors.

## 5. Write the graph spec function

The final graph is written as a function. 
Add a function under `src/graphs/<category>/` (`gdp/`, `employment/`, `prices/`, or `trade/` — reuse an existing file if your graph is a close relative of what's already there, e.g. shares a cached raw fetch). The function should take `y_axis`/`caption` (or whatever labels the plot needs) plus `decimal_mark`/`big_mark` as arguments, defaulting to German formatting (`decimal_mark = ","`, `big_mark = "."`) since that's the primary audience — the English call overrides them:

```r
# src/graphs/gdp/my_new_graph.R
my_new_graph <- function(y_axis, caption, decimal_mark = ",", big_mark = ".") {
  dat <- with_cache(paste0("genesis_XXXXX-XXXX_", DATA_START_YEAR),
                    genesis_fetch("XXXXX-XXXX")) |>
    parse_genesis(value_var = "...", series_name = "my_series", geo = "DEU") |>
    dplyr::filter(date >= as.Date(paste0(DATA_START_YEAR, "-01-01")))
  plot_timeseries(dat, y_axis = y_axis, caption = caption,
                  decimal_mark = decimal_mark, big_mark = big_mark)
}
```

If a chart needs multiple raw fetches or several closely-related variants (e.g. level/growth/volume from the same table), follow the pattern in [src/graphs/gdp/ger_bip_annual.R](src/graphs/gdp/ger_bip_annual.R): a shared private `.helper()` that both fetches and filters, called by several thin public wrapper functions.

## 6. Add the graph module metadata

At the bottom of the graph file, add an entry to `.graph_specs`. Its `render()` calls your function twice—German first and English second—and writes into the category's two output folders:

To have an AI coding assistant create this block, use
[prompts/generate_graph_metadata.md](prompts/generate_graph_metadata.md). Give
it the path of the graph file after the plotting functions are implemented.

```r
.graph_specs <- list(list(
  id = "my_new_graph", category = "GDP",
  label = "My New Graph — short human-readable label for the menu",
  render = function() {
    GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
    EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
    render_graph(
      my_new_graph("Y-Achsen-Beschriftung", "Datenquelle: Statistisches Bundesamt (Destatis)"),
      "My New Graph title_ger", GER)
    render_graph(
      my_new_graph("Y-axis label", "Data source: Federal statistical office (Destatis)",
                    decimal_mark = ".", big_mark = ","),
      "My New Graph title_en", EN)
  }
))

if (!exists("auto_run_graph_file", mode = "function")) source("src/graph_modules.R")
auto_run_graph_file("src/graphs/gdp/my_new_graph.R", .graph_specs)
```

Conventions to match the existing entries:
- `id`: unique, snake_case, stable (used for logging and error messages — don't rename once graphs are in production use)
- `category`: one of `"GDP"`, `"Employment"`, `"Prices"`, `"Trade"` (drives the menu grouping and the `run_*.R` batch filters)
- In render: 
  - `GER`: output path of the German labeling version
  - `EN`: output path of the English labeling version

## 7. Test it

The file is directly executable, so the fastest end-to-end check is:

```bash
Rscript src/graphs/gdp/my_new_graph.R
```

To inspect intermediate values while iterating, source it without triggering rendering:

```r
source("src/bootstrap.R")
source("src/graphs/gdp/my_new_graph.R")
p <- my_new_graph("Test axis", "Test caption")
render_graph(p, "test_my_new_graph", "out/test")
```

or just `print(p)` in an interactive R session / RStudio viewer to inspect the plot without writing a file.
