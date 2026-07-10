REGION_CODES <- c("Z4", "Z7", "ZJ", "ZQ", "XU", "8S", "ZG")
REGION_ISO3C <- c("EAS", "ECS", "LCN", "MEA", "NAC", "SAS", "SSF")

gdp_world_by_region <- function(y_axis, caption, labels,
                                  decimal_mark = ".", big_mark = ",") {
  dat <- with_cache(paste0("wdi_NY.GDP.PCAP.PP.KD_regions_", DATA_START_YEAR),
                    fetch_wdi("NY.GDP.PCAP.PP.KD", country = REGION_CODES))
  region_labels <- setNames(labels, REGION_ISO3C)
  dat <- dat |>
    dplyr::filter(!is.na(value)) |>
    dplyr::mutate(series = dplyr::coalesce(region_labels[geo], series))
  plot_timeseries_multi(dat, y_axis = y_axis, caption = caption,
                        colors = c(hwwi_light_blue, hwwi_blue, hwwi_dark_blue,
                                   hwwi_rubin, hwwi_dark_rubin, hwwi_grey, hwwi_dark_grey),
                        decimal_mark = decimal_mark, big_mark = big_mark)
}
