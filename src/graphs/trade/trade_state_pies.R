# Pie charts for trade structure by commodity group (top 10 + rest).
# Hamburg/LS from GENESIS 51000-0034; Germany from 51000-0005.

.state_pie <- function(state_key, state_label, direction,
                        caption, big_mark, decimal_mark, n_inside, start_angle) {
  year <- as.integer(format(Sys.Date(), "%Y")) - 1
  raw  <- with_cache(paste0("genesis_51000-0034_", state_label, "_", year),
                     fetch_state_trade_commodity(year, state_key = state_key))
  top  <- raw[1:10, c("Group", direction)]
  rest <- setNames(
    data.frame("Sonstige", sum(raw[[direction]][11:nrow(raw)], na.rm = TRUE)),
    c("Group", direction)
  )
  plot_pie(rbind(top, rest), group_col = "Group", value_col = direction,
            caption = caption, big_mark = big_mark, decimal_mark = decimal_mark,
            n_inside = n_inside, text_size = 2.4,
            start_angle = start_angle, x_limit = 4.75,
            plot_margin = ggplot2::margin(-20, 100, 20, -100))
}

trade_export_hamburg_pie <- function(caption, big_mark = ".", decimal_mark = ",")
  .state_pie("02", "HH", "Export", caption, big_mark, decimal_mark,
              n_inside = 2, start_angle = pi / 3)

trade_import_hamburg_pie <- function(caption, big_mark = ".", decimal_mark = ",")
  .state_pie("02", "HH", "Import", caption, big_mark, decimal_mark,
              n_inside = 2, start_angle = pi / 3)

trade_export_lowersaxony_pie <- function(caption, big_mark = ".", decimal_mark = ",")
  .state_pie("03", "LS", "Export", caption, big_mark, decimal_mark,
              n_inside = 1, start_angle = pi / 4.5)

trade_import_lowersaxony_pie <- function(caption, big_mark = ".", decimal_mark = ",")
  .state_pie("03", "LS", "Import", caption, big_mark, decimal_mark,
              n_inside = 1, start_angle = pi / 4.5)

trade_export_germany_pie <- function(caption, big_mark = ".", decimal_mark = ",") {
  year <- as.integer(format(Sys.Date(), "%Y")) - 1
  raw  <- with_cache(paste0("genesis_51000-0005_", year), fetch_ger_trade_commodity(year))
  top  <- raw[1:10, c("Group", "GerExport")]
  rest <- data.frame(Group = "Sonstige",
                     GerExport = sum(raw$GerExport[11:nrow(raw)], na.rm = TRUE))
  plot_pie(rbind(top, rest), group_col = "Group", value_col = "GerExport",
            caption = caption, big_mark = big_mark, decimal_mark = decimal_mark,
            n_inside = 1, inside_x = 2)
}

trade_import_germany_pie <- function(caption, big_mark = ".", decimal_mark = ",") {
  year <- as.integer(format(Sys.Date(), "%Y")) - 1
  raw  <- with_cache(paste0("genesis_51000-0005_", year), fetch_ger_trade_commodity(year))
  top  <- raw[1:10, c("Group", "GerImport")]
  rest <- data.frame(Group     = "Sonstige",
                     GerImport = sum(raw$GerImport[11:nrow(raw)], na.rm = TRUE))
  plot_pie(rbind(top, rest), group_col = "Group", value_col = "GerImport",
            caption = caption, big_mark = big_mark, decimal_mark = decimal_mark,
            n_inside = 1, inside_x = 2)
}
