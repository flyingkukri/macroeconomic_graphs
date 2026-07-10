# Long-term government bond yields: top 5 (highest) and bottom 5 (lowest) EU countries.
# Data: Eurostat ei_mfir_m, indicator MF-LTGBY-RT (10-year benchmark bonds), monthly.

.parse_estat_json <- function(r) {
  parsed  <- jsonlite::fromJSON(r, simplifyVector = FALSE)
  dim_ids <- unlist(parsed$id)
  sizes   <- as.integer(unlist(parsed$size))
  n_dims  <- length(sizes)

  # Row-major strides
  strides         <- integer(n_dims)
  strides[n_dims] <- 1L
  if (n_dims > 1)
    for (i in (n_dims - 1L):1L) strides[i] <- strides[i + 1L] * sizes[i + 1L]

  # Position → code for each dimension
  pos_to_code <- lapply(dim_ids, function(d) {
    idx <- unlist(parsed$dimension[[d]]$category$index)
    setNames(names(idx), as.character(as.integer(idx)))
  })

  vals <- parsed$value
  rows <- lapply(names(vals), function(pos_str) {
    pos  <- as.integer(pos_str)
    rem  <- pos
    codes <- character(n_dims)
    for (i in seq_len(n_dims)) {
      dim_pos  <- rem %/% strides[i]
      rem      <- rem %%  strides[i]
      codes[i] <- pos_to_code[[i]][as.character(dim_pos)]
    }
    names(codes) <- dim_ids
    c(as.list(codes), list(value = vals[[pos_str]]))
  })

  rows_flat <- lapply(rows, function(x) lapply(x, function(v) if (is.list(v)) v[[1]] else v))
  col_names <- names(rows_flat[[1]])
  cols <- setNames(
    lapply(col_names, function(nm) sapply(rows_flat, function(r) r[[nm]])),
    col_names
  )
  as.data.frame(cols, stringsAsFactors = FALSE)
}

ger_govt_bond_yields <- function(y_axis, caption, decimal_mark = ",",
                                  country_names = NULL) {
  start <- as.Date(paste0(DATA_START_YEAR, "-01-01"))

  raw_json <- with_cache(paste0("estat_ltgby_", DATA_START_YEAR), {
    url <- paste0(
      "https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/ei_mfir_m",
      "?format=JSON&indic=MF-LTGBY-RT&sinceTimePeriod=", DATA_START_YEAR, "-01&lang=EN"
    )
    r <- tryCatch(
      httr2::request(url) |> httr2::req_timeout(60) |> httr2::req_perform() |>
        httr2::resp_body_string(),
      error = function(e) NULL
    )
    if (is.null(r)) stop("Could not fetch Eurostat government bond yields")
    r
  })

  dat <- .parse_estat_json(raw_json)
  dat$date  <- as.Date(paste0(dat$time, "-01"))
  dat$value <- as.numeric(dat$value)
  dat <- dat[!is.na(dat$value) & dat$date >= start, ]

  # Select top 5 and bottom 5 countries by most recent month
  latest  <- max(dat$date, na.rm = TRUE)
  recent  <- dat[dat$date == latest, ]
  recent  <- recent[order(recent$value), ]
  sel_geo <- unique(c(head(recent$geo, 5), tail(recent$geo, 5)))

  plot_dat <- dat[dat$geo %in% sel_geo, ]

  if (!is.null(country_names)) {
    plot_dat$series <- dplyr::coalesce(country_names[plot_dat$geo], plot_dat$geo)
  } else {
    plot_dat$series <- plot_dat$geo
  }

  palette <- c(hwwi_light_blue, hwwi_blue, hwwi_dark_blue, hwwi_grey, hwwi_dark_rubin,
               hwwi_dark_grey, hwwi_rubin, hwwi_light_blue, hwwi_blue, hwwi_dark_rubin)

  ggplot2::ggplot(plot_dat,
    ggplot2::aes(x = date, y = value, color = series)) +
    ggplot2::geom_line(linewidth = 1.4) +
    ggplot2::scale_colour_manual("", values = palette[seq_along(sel_geo)]) +
    ggplot2::scale_x_date(date_breaks = "2 years", date_labels = "%Y",
                           limits = c(start, latest), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(
      labels = function(x) format(x, decimal.mark = decimal_mark, scientific = FALSE)
    ) +
    ggplot2::labs(x = "", y = y_axis, caption = caption) +
    hwwi_theme() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::guides(color = ggplot2::guide_legend(nrow = 3))
}
