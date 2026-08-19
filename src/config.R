# ── Data ──────────────────────────────────────────────────────────────────────
DATA_START_YEAR <- 2000   # earliest year to fetch for all time series
HH_AIRCRAFT_ARCHIVE_START_YEAR <- 2000  # stable cache key for retired EGW883 history

# World Bank aggregate regions used by both regional GDP graph modules. Keep
# these in shared configuration because graph discovery sources each module in
# an isolated environment.
REGION_CODES <- c("Z4", "Z7", "ZJ", "ZQ", "XU", "8S", "ZG")
REGION_ISO3C <- c("EAS", "ECS", "LCN", "MEA", "NAC", "SAS", "SSF")

# ── Paths ─────────────────────────────────────────────────────────────────────
OUT_DIR   <- "out"
CACHE_DIR <- "cache"

# ── Render defaults ───────────────────────────────────────────────────────────
OUT_FORMAT <- "jpeg"
OUT_WIDTH  <- 11    # inches
OUT_HEIGHT <- 6     # inches
OUT_DPI    <- 300
