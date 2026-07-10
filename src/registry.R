.graph_registry <- list(

  # ── GDP ───────────────────────────────────────────────────────────────────────

  list(
    id = "world_gdp_development", category = "GDP",
    label = "World Real GDP Development",
    spec  = "src/graphs/gdp/wdi_gdp.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_world_development("BIP (in Milliarden 2015 US$)",
                               "Datenquelle: Nationale Statistik der Weltbank und OECD",
                               decimal_mark = ",", big_mark = "."),
        "W GDP real annual Level_ger", GER)
      render_graph(
        gdp_world_development("GDP (in Billion 2015 US$)",
                               "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                               decimal_mark = ".", big_mark = ","),
        "W GDP real annual Level_en", EN)
    }
  ),

  list(
    id = "world_gdp_by_region", category = "GDP",
    label = "World GDP Per Capita by Region",
    spec  = "src/graphs/gdp/world_gdp_by_region.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_world_by_region("BIP Pro Kopf, PPP (in 2021 International $)",
                             "Datenquelle: Nationale Statistik der Weltbank und OECD",
                             labels = c("Ostasien und Pazifik", "Europa & Zentralasien",
                                        "Lateinamerika & Karibik", "Mittlerer Osten & Nordafrika",
                                        "Nordamerika", "Südasien", "Sub-Sahara Afrika"),
                             decimal_mark = ",", big_mark = "."),
        "W GDP p.c. (PPP) real annual Level World Regions_ger", GER)
      render_graph(
        gdp_world_by_region("GDP Per Capita, PPP (in 2021 International $)",
                             "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                             labels = c("East Asia & Pacific", "Europe & Central Asia",
                                        "Latin America & Caribbean", "Middle East & North Africa",
                                        "North America", "South Asia", "Sub-Saharan Africa"),
                             decimal_mark = ".", big_mark = ","),
        "W GDP p.c. (PPP) real annual Level World Regions_en", EN)
    }
  ),

  list(
    id = "world_gdp_growth", category = "GDP",
    label = "World GDP Growth Rate (WDI)",
    spec  = "src/graphs/gdp/wdi_gdp.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_world_growth("BIP-Wachstum (in %)",
                          "Datenquelle: Nationale Statistik der Weltbank und OECD",
                          decimal_mark = ","),
        "W GDP real annual Growth_ger", GER)
      render_graph(
        gdp_world_growth("GDP Growth (in %)",
                          "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files"),
        "W GDP real annual Growth_en", EN)
    }
  ),

  list(
    id = "world_gdp_by_region_growth", category = "GDP",
    label = "World GDP Per Capita Growth by Region",
    spec  = "src/graphs/gdp/world_gdp_by_region_growth.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_world_by_region_growth("BIP pro Kopf Wachstum (in %)",
                                    "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                    labels = c("Ostasien und Pazifik", "Europa & Zentralasien",
                                               "Lateinamerika & Karibik", "Naher Osten & Nordafrika",
                                               "Nordamerika", "Südasien", "Sub-Sahara Afrika"),
                                    decimal_mark = ","),
        "W GDP p.c. real annual Growth World Regions_ger", GER)
      render_graph(
        gdp_world_by_region_growth("GDP Per Capita Growth (in %)",
                                    "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                                    labels = c("East Asia & Pacific", "Europe & Central Asia",
                                               "Latin America & Caribbean", "Middle East & North Africa",
                                               "North America", "South Asia", "Sub-Saharan Africa")),
        "W GDP p.c. real annual Growth World Regions_en", EN)
    }
  ),

  list(
    id = "germany_gdp_development", category = "GDP",
    label = "Germany Real GDP Development (WDI)",
    spec  = "src/graphs/gdp/wdi_gdp.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_germany_development("Reales BIP (in Milliarden 2015 US$)",
                                 "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                 decimal_mark = ",", big_mark = "."),
        "GER GDP real annual Level WDI_ger", GER)
      render_graph(
        gdp_germany_development("Real GDP (in Billion 2015 US$)",
                                 "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                                 big_mark = ","),
        "GER GDP real annual Level WDI_en", EN)
    }
  ),

  list(
    id = "germany_gdp_growth", category = "GDP",
    label = "Germany GDP Growth Rate (WDI)",
    spec  = "src/graphs/gdp/wdi_gdp.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_germany_growth("BIP-Wachstum (in %)",
                            "Datenquelle: Nationale Statistik der Weltbank und OECD",
                            decimal_mark = ","),
        "GER GDP real annual Growth WDI_ger", GER)
      render_graph(
        gdp_germany_growth("GDP Growth (in %)",
                            "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files"),
        "GER GDP real annual Growth WDI_en", EN)
    }
  ),

  list(
    id = "ger_bip_annual_growth", category = "GDP",
    label = "Germany Annual GDP Growth (Destatis)",
    spec  = "src/graphs/gdp/ger_bip_annual.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_annual_growth("Kettenindex (2020=100) \n Veränderung in %",
                               "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER BIP annual growth - chain index_ger", GER)
      render_graph(
        ger_bip_annual_growth("Chain index (2020=100) \n Change in %",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = "."),
        "GER BIP annual growth - chain index_en", EN)
    }
  ),

  list(
    id = "ger_bip_annual_development", category = "GDP",
    label = "Germany Annual GDP Level - Chain Index (Destatis)",
    spec  = "src/graphs/gdp/ger_bip_annual.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_annual_development("Kettenindex (2020=100)",
                                    "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER BIP annual level - chain index_ger", GER)
      render_graph(
        ger_bip_annual_development("Chain Index (2020=100)",
                                    "Data source: Federal statistical office (Destatis)",
                                    decimal_mark = "."),
        "GER BIP annual level - chain index_en", EN)
    }
  ),

  list(
    id = "ger_bip_annual_volume", category = "GDP",
    label = "Germany Annual GDP - Chain-linked Volume (Mrd EUR, Destatis)",
    spec  = "src/graphs/gdp/ger_bip_annual.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_annual_volume("Verkettete Volumenangaben (Mrd. EUR)",
                               "Datenquelle: Statistisches Bundesamt (Destatis)",
                               decimal_mark = ",", big_mark = "."),
        "GER BIP annual - chain-linked volume data (bn EUR)_ger", GER)
      render_graph(
        ger_bip_annual_volume("Chain-linked volume data (bn EUR)",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = ".", big_mark = ","),
        "GER BIP annual - chain-linked volume data (bn EUR)_en", EN)
    }
  ),

  list(
    id = "ger_nominal_gdp", category = "GDP",
    label = "Germany Nominal GDP (Destatis)",
    spec  = "src/graphs/gdp/ger_bip_annual.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_nominal_gdp("Nominales BIP (in Mrd. EUR)",
                         "Datenquelle: Statistisches Bundesamt (Destatis)",
                         decimal_mark = ",", big_mark = "."),
        "GER BIP nominal annual_ger", GER)
      render_graph(
        ger_nominal_gdp("Nominal GDP (in Billion EUR)",
                         "Data source: Federal statistical office (Destatis)",
                         decimal_mark = ".", big_mark = ","),
        "GER BIP nominal annual_en", EN)
    }
  ),

  list(
    id = "ger_nominal_gdp_state", category = "GDP",
    label = "Germany Nominal GDP by State - Bar Chart (Destatis)",
    spec  = "src/graphs/gdp/ger_nominal_gdp_state.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_nominal_gdp_state("Nominales BIP (in Mrd. EUR)",
                               "Datenquelle: Statistisches Bundesamt (Destatis)",
                               decimal_mark = ",", big_mark = "."),
        "GER BIP nominal by state_ger", GER, height = 7)
      render_graph(
        ger_nominal_gdp_state("Nominal GDP (in Billion EUR)",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = ".", big_mark = ","),
        "GER BIP nominal by state_en", EN, height = 7)
    }
  ),

  list(
    id = "ger_nominal_gdp_state_per_capita", category = "GDP",
    label = "Germany Nominal GDP per Capita by State (StatLA)",
    spec  = "src/graphs/gdp/ger_nominal_gdp_state_per_capita.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_nominal_gdp_state_per_capita(
          "Nominales BIP pro Einwohner (in EUR)",
          "Datenquelle: Statistische Ämter des Bundes und der Länder",
          decimal_mark = ",", big_mark = "."),
        "GER Nominal GDP by State per Capita_ger", GER, height = 7)
      render_graph(
        ger_nominal_gdp_state_per_capita(
          "Nominal GDP per Capita (in EUR)",
          "Data source: Federal and State Statistical Offices",
          decimal_mark = ".", big_mark = ","),
        "GER Nominal GDP by State per Capita_en", EN, height = 7)
    }
  ),

  list(
    id = "ger_nominal_gdp_state_per_capita_map", category = "GDP",
    label = "Germany Nominal GDP per Capita by State - Choropleth (StatLA)",
    spec  = "src/graphs/gdp/ger_nominal_gdp_state_per_capita.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_nominal_gdp_state_per_capita_map(
          "Nominales BIP pro Einwohner (in EUR)",
          "Datenquelle: Statistische Ämter des Bundes und der Länder"),
        "GER Nominal GDP by State per Capita Map_ger", GER)
      render_graph(
        ger_nominal_gdp_state_per_capita_map(
          "Nominal GDP per Capita (in EUR)",
          "Data source: Federal and State Statistical Offices"),
        "GER Nominal GDP by State per Capita Map_en", EN)
    }
  ),

  list(
    id = "ger_bip_quarterly_development", category = "GDP",
    label = "Germany Quarterly GDP Level - Chain Index (Destatis)",
    spec  = "src/graphs/gdp/ger_bip_quarterly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_quarterly_development("Kettenindex (2020=100), saisonbereinigt",
                                       "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER BIP quarterly level - chain index_ger", GER)
      render_graph(
        ger_bip_quarterly_development("Chain Index (2020=100), seasonally adjusted",
                                       "Data source: Federal statistical office (Destatis)",
                                       decimal_mark = "."),
        "GER BIP quarterly level - chain index_en", EN)
    }
  ),

  list(
    id = "ger_bip_quarterly_growth", category = "GDP",
    label = "Germany Quarterly GDP Growth Rate (Destatis)",
    spec  = "src/graphs/gdp/ger_bip_quarterly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_quarterly_growth("Veränderung gg. Vj. (in %), saisonbereinigt",
                                  "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER BIP quarterly growth_ger", GER)
      render_graph(
        ger_bip_quarterly_growth("Change vs. prev. year (in %), seasonally adjusted",
                                  "Data source: Federal statistical office (Destatis)",
                                  decimal_mark = "."),
        "GER BIP quarterly growth_en", EN)
    }
  ),

  list(
    id = "high_income_gdppc_development", category = "GDP",
    label = "High Income GDP Per Capita Development (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_development.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_high_income_development("BIP pro Kopf, PPP (in 2021 Int'l $) – Hocheinkommensländer",
                                     "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                     decimal_mark = ",", big_mark = "."),
        "HIC GDP p.c. (PPP) real annual Level_ger", GER)
      render_graph(
        gdp_high_income_development("GDP Per Capita, PPP (in 2021 Int'l $) – High Income",
                                     "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                                     big_mark = ","),
        "HIC GDP p.c. (PPP) real annual Level_en", EN)
    }
  ),

  list(
    id = "high_income_gdppc_growth", category = "GDP",
    label = "High Income GDP Per Capita Growth (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_growth.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_high_income_growth("BIP pro Kopf Wachstum (in %) – Hocheinkommensländer",
                                "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                decimal_mark = ","),
        "HIC GDP p.c. real annual Growth_ger", GER)
      render_graph(
        gdp_high_income_growth("GDP Per Capita Growth (in %) – High Income",
                                "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files"),
        "HIC GDP p.c. real annual Growth_en", EN)
    }
  ),

  list(
    id = "upper_middle_gdppc_development", category = "GDP",
    label = "Upper Middle Income GDP Per Capita Development (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_development.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_upper_middle_development("BIP pro Kopf, PPP (in 2021 Int'l $) – Obere Mitteleinkommensländer",
                                      "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                      decimal_mark = ",", big_mark = "."),
        "UMC GDP p.c. (PPP) real annual Level_ger", GER)
      render_graph(
        gdp_upper_middle_development("GDP Per Capita, PPP (in 2021 Int'l $) – Upper Middle Income",
                                      "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                                      big_mark = ","),
        "UMC GDP p.c. (PPP) real annual Level_en", EN)
    }
  ),

  list(
    id = "upper_middle_gdppc_growth", category = "GDP",
    label = "Upper Middle Income GDP Per Capita Growth (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_growth.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_upper_middle_growth("BIP pro Kopf Wachstum (in %) – Obere Mitteleinkommensländer",
                                 "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                 decimal_mark = ","),
        "UMC GDP p.c. real annual Growth_ger", GER)
      render_graph(
        gdp_upper_middle_growth("GDP Per Capita Growth (in %) – Upper Middle Income",
                                 "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files"),
        "UMC GDP p.c. real annual Growth_en", EN)
    }
  ),

  list(
    id = "lower_middle_gdppc_development", category = "GDP",
    label = "Lower Middle Income GDP Per Capita Development (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_development.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_lower_middle_development("BIP pro Kopf, PPP (in 2021 Int'l $) – Untere Mitteleinkommensländer",
                                      "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                      decimal_mark = ",", big_mark = "."),
        "LMC GDP p.c. (PPP) real annual Level_ger", GER)
      render_graph(
        gdp_lower_middle_development("GDP Per Capita, PPP (in 2021 Int'l $) – Lower Middle Income",
                                      "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                                      big_mark = ","),
        "LMC GDP p.c. (PPP) real annual Level_en", EN)
    }
  ),

  list(
    id = "lower_middle_gdppc_growth", category = "GDP",
    label = "Lower Middle Income GDP Per Capita Growth (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_growth.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_lower_middle_growth("BIP pro Kopf Wachstum (in %) – Untere Mitteleinkommensländer",
                                 "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                 decimal_mark = ","),
        "LMC GDP p.c. real annual Growth_ger", GER)
      render_graph(
        gdp_lower_middle_growth("GDP Per Capita Growth (in %) – Lower Middle Income",
                                 "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files"),
        "LMC GDP p.c. real annual Growth_en", EN)
    }
  ),

  list(
    id = "low_income_gdppc_development", category = "GDP",
    label = "Low Income GDP Per Capita Development (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_development.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_low_income_development("BIP pro Kopf, PPP (in 2021 Int'l $) – Niedrigeinkommensländer",
                                    "Datenquelle: Nationale Statistik der Weltbank und OECD",
                                    decimal_mark = ",", big_mark = "."),
        "LIC GDP p.c. (PPP) real annual Level_ger", GER)
      render_graph(
        gdp_low_income_development("GDP Per Capita, PPP (in 2021 Int'l $) – Low Income",
                                    "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                                    big_mark = ","),
        "LIC GDP p.c. (PPP) real annual Level_en", EN)
    }
  ),

  list(
    id = "low_income_gdppc_growth", category = "GDP",
    label = "Low Income GDP Per Capita Growth (WDI)",
    spec  = "src/graphs/gdp/income_gdppc_growth.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        gdp_low_income_growth("BIP pro Kopf Wachstum (in %) – Niedrigeinkommensländer",
                               "Datenquelle: Nationale Statistik der Weltbank und OECD",
                               decimal_mark = ","),
        "LIC GDP p.c. real annual Growth_ger", GER)
      render_graph(
        gdp_low_income_growth("GDP Per Capita Growth (in %) – Low Income",
                               "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files"),
        "LIC GDP p.c. real annual Growth_en", EN)
    }
  ),

  # ── Employment ────────────────────────────────────────────────────────────────

  list(
    id = "ger_unemployment_rate", category = "Employment",
    label = "Germany Unemployment Rate",
    spec  = "src/graphs/employment/ger_unemployment_rate.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_unemployment_rate("Arbeitslosenquote (in %)",
                               "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER unemployment rate_ger", GER)
      render_graph(
        ger_unemployment_rate("Unemployment Rate (in %)",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = "."),
        "GER unemployment rate_en", EN)
    }
  ),

  list(
    id = "ger_registered_unemployed_monthly", category = "Employment",
    label = "Germany Registered Unemployed (monthly, total)",
    spec  = "src/graphs/employment/ger_registered_unemployed_monthly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_registered_unemployed_monthly("Arbeitslose (in Mio.)",
                                           "Datenquelle: Statistisches Bundesamt (Destatis)",
                                           decimal_mark = ",", big_mark = "."),
        "GER registered unemployed monthly_ger", GER)
      render_graph(
        ger_registered_unemployed_monthly("Registered Unemployed (in million)",
                                           "Data source: Federal statistical office (Destatis)",
                                           decimal_mark = ".", big_mark = ","),
        "GER registered unemployed monthly_en", EN)
    }
  ),

  list(
    id = "ger_employed_unemployed", category = "Employment",
    label = "Germany Employed and Unemployed Persons",
    spec  = "src/graphs/employment/ger_employed_unemployed.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_employed_unemployed(
          caption          = "Datenquelle: Statistisches Bundesamt (Destatis)",
          label_employed   = "Erwerbstätige",
          label_unemployed = "Erwerbslose",
          y_axis_left      = "Erwerbstätige (in Mio.)",
          y_axis_right     = "Erwerbslose (in Mio.)",
          decimal_mark     = ",", big_mark = "."),
        "GER employed unemployed_ger", GER)
      render_graph(
        ger_employed_unemployed(
          caption          = "Data source: Federal statistical office (Destatis)",
          label_employed   = "Employed",
          label_unemployed = "Unemployed",
          y_axis_left      = "Employed (in million)",
          y_axis_right     = "Unemployed (in million)",
          decimal_mark     = ".", big_mark = ","),
        "GER employed unemployed_en", EN)
    }
  ),

  list(
    id = "ger_employment_rate", category = "Employment",
    label = "Germany Employment Rate",
    spec  = "src/graphs/employment/ger_employment_rate.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_employment_rate("Erwerbsquote (in %)",
                             "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER employment rate_ger", GER)
      render_graph(
        ger_employment_rate("Employment Rate (in %)",
                             "Data source: Federal statistical office (Destatis)",
                             decimal_mark = "."),
        "GER employment rate_en", EN)
    }
  ),

  list(
    id = "ger_employed_seasonal", category = "Employment",
    label = "Germany Employed Persons, Quarterly Seasonally Adjusted",
    spec  = "src/graphs/employment/ger_employed_seasonal.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_employed_seasonal("Anzahl Erwerbstätige (in Tsd.), saisonbereinigt",
                               "Datenquelle: Statistisches Bundesamt (Destatis)",
                               decimal_mark = ",", big_mark = "."),
        "GER employed persons quarterly seasonally adjusted_ger", GER)
      render_graph(
        ger_employed_seasonal("Number of Employed Persons (in 1000), seasonally adjusted",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = ".", big_mark = ","),
        "GER employed persons quarterly seasonally adjusted_en", EN)
    }
  ),

  list(
    id = "ger_unemployment_seasonal", category = "Employment",
    label = "Germany Unemployment Rate, Quarterly Seasonally Adjusted",
    spec  = "src/graphs/employment/ger_unemployment_seasonal.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_unemployment_seasonal("Erwerbslosenquote in %, saisonbereinigt",
                                   "Datenquelle: Statistisches Bundesamt (Destatis)",
                                   decimal_mark = ","),
        "GER unemployed persons quarterly seasonally adjusted_ger", GER)
      render_graph(
        ger_unemployment_seasonal("Unemployment rate in %, seasonally adjusted",
                                   "Data source: Federal statistical office (Destatis)",
                                   decimal_mark = "."),
        "GER unemployed persons quarterly seasonally adjusted_en", EN)
    }
  ),

  list(
    id = "ger_unemployment_civilian", category = "Employment",
    label = "Germany Unemployment Rate: Civilian and Registered (annual)",
    spec  = "src/graphs/employment/ger_unemployment_civilian.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_unemployment_civilian(
          y_axis    = "Arbeitslosenquote in %",
          caption   = "Datenquelle: Statistisches Bundesamt (Destatis)",
          label_all = "Arbeitslosenquote aller ziv. Erwerbspersonen",
          label_dep = "Arbeitslosenquote abh. ziv. Erwerbspersonen",
          decimal_mark = ","),
        "GER unemployment rate civilian and registered_ger", GER)
      render_graph(
        ger_unemployment_civilian(
          y_axis    = "Unemployment rate in %",
          caption   = "Data source: Federal statistical office (Destatis)",
          label_all = "Unemployment as percent of civilian labour force",
          label_dep = "Rate of registered unemployed",
          decimal_mark = "."),
        "GER unemployment rate civilian and registered_en", EN)
    }
  ),

  list(
    id = "ger_unemployed_west_east", category = "Employment",
    label = "Germany Registered Unemployed: West vs East",
    spec  = "src/graphs/employment/ger_unemployed_west_east.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_unemployed_west_east("Arbeitslose (in Mio.)",
                                  "Datenquelle: Statistisches Bundesamt (Destatis)",
                                  labels = c("Früheres Bundesgebiet", "Neue Länder"),
                                  decimal_mark = ",", big_mark = "."),
        "GER unemployed west east_ger", GER)
      render_graph(
        ger_unemployed_west_east("Unemployed in Mill.",
                                  "Data source: Federal statistical office (Destatis)",
                                  labels = c("West Germany", "East Germany"),
                                  decimal_mark = ".", big_mark = ","),
        "GER unemployed west east_en", EN)
    }
  ),

  list(
    id = "ger_employed_gdp_quarterly", category = "Employment",
    label = "Germany Employed Persons and GDP - Quarterly Seasonally Adjusted",
    spec  = "src/graphs/employment/ger_employed_gdp_quarterly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_employed_gdp_quarterly(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          label_employed = "Erwerbstätige (Arbeitsort, saisonbereinigt)",
          label_bip      = "BIP (saisonbereinigt, preisbereinigt, verkettet)",
          y_axis_left    = "Anzahl Erwerbstätige (in Tsd.)",
          y_axis_right   = "BIP nach Quartalen (Mrd. EUR)",
          decimal_mark   = ",", big_mark = "."),
        "GER number of employed persons and gdp by quarter (seasonal adjusted)_ger", GER)
      render_graph(
        ger_employed_gdp_quarterly(
          caption        = "Data source: Federal Statistical Office (Destatis)",
          label_employed = "Employed persons (in Germany, seasonally adjusted)",
          label_bip      = "GDP (seasonally adjusted, price adjusted, chain-linked)",
          y_axis_left    = "Number of employed persons (in 1000)",
          y_axis_right   = "GDP by quarter (bn EUR)",
          decimal_mark   = ".", big_mark = ","),
        "GER number of employed persons and gdp by quarter (seasonal adjusted)_en", EN)
    }
  ),

  # ── Prices ────────────────────────────────────────────────────────────────────

  list(
    id = "ger_cpi", category = "Prices",
    label = "Germany Consumer Price Index",
    spec  = "src/graphs/prices/ger_cpi.R",
    render = function() {
      GER <- file.path(OUT_DIR, "prices graphs/German labeling")
      EN  <- file.path(OUT_DIR, "prices graphs/English labeling")
      render_graph(
        ger_cpi("Verbraucherpreisindex (2020=100)",
                 "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER Consumer Price Index_ger", GER)
      render_graph(
        ger_cpi("Consumer Price Index (2020=100)",
                 "Data source: Federal statistical office (Destatis)"),
        "GER Consumer Price Index_en", EN)
    }
  ),

  list(
    id = "ger_inflation_rate", category = "Prices",
    label = "Germany Inflation Rate (monthly YoY)",
    spec  = "src/graphs/prices/ger_inflation_rate.R",
    render = function() {
      GER <- file.path(OUT_DIR, "prices graphs/German labeling")
      EN  <- file.path(OUT_DIR, "prices graphs/English labeling")
      render_graph(
        ger_inflation_rate("Inflationsrate (Veränderung gg. Vj., in %)",
                            "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "GER inflation rate monthly_ger", GER)
      render_graph(
        ger_inflation_rate("Inflation Rate (change vs. prev. year, in %)",
                            "Data source: Federal statistical office (Destatis)",
                            decimal_mark = "."),
        "GER inflation rate monthly_en", EN)
    }
  ),

  # ── Trade ─────────────────────────────────────────────────────────────────────

  list(
    id = "trade_export_hamburg", category = "Trade",
    label = "Hamburg Exports (with/without aircraft)",
    spec  = "src/graphs/trade/trade_state_bars.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_export_hamburg("Exporte (in Mrd. EUR)",
                              "Datenquelle: Statistisches Bundesamt (Destatis)",
                              labels = c("Gesamtexporte", "Exporte ohne Luft- und Raumfahrzeuge"),
                              decimal_mark = ","),
        "Export Hamburg_ger", GER)
      render_graph(
        trade_export_hamburg("Exports (in Billion EUR)",
                              "Data source: Federal statistical office (Destatis)",
                              labels = c("Total Exports", "Exports excl. Aircraft"),
                              decimal_mark = "."),
        "Export Hamburg_en", EN)
    }
  ),

  list(
    id = "trade_import_hamburg", category = "Trade",
    label = "Hamburg Imports (with/without aircraft)",
    spec  = "src/graphs/trade/trade_state_bars.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_import_hamburg("Importe (in Mrd. EUR)",
                              "Datenquelle: Statistisches Bundesamt (Destatis)",
                              labels = c("Gesamtimporte", "Importe ohne Luft- und Raumfahrzeuge"),
                              decimal_mark = ","),
        "Import Hamburg_ger", GER)
      render_graph(
        trade_import_hamburg("Imports (in Billion EUR)",
                              "Data source: Federal statistical office (Destatis)",
                              labels = c("Total Imports", "Imports excl. Aircraft"),
                              decimal_mark = "."),
        "Import Hamburg_en", EN)
    }
  ),

  list(
    id = "trade_export_germany", category = "Trade",
    label = "Germany Total Exports (annual)",
    spec  = "src/graphs/trade/trade_state_bars.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_export_germany("Ausfuhren (in Mrd. EUR)",
                              "Datenquelle: Statistisches Bundesamt (Destatis)",
                              decimal_mark = ","),
        "Export Germany_ger", GER)
      render_graph(
        trade_export_germany("Exports (in Billion EUR)",
                              "Data source: Federal statistical office (Destatis)",
                              decimal_mark = "."),
        "Export Germany_en", EN)
    }
  ),

  list(
    id = "trade_import_germany", category = "Trade",
    label = "Germany Total Imports (annual)",
    spec  = "src/graphs/trade/trade_state_bars.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_import_germany("Einfuhren (in Mrd. EUR)",
                              "Datenquelle: Statistisches Bundesamt (Destatis)",
                              decimal_mark = ","),
        "Import Germany_ger", GER)
      render_graph(
        trade_import_germany("Imports (in Billion EUR)",
                              "Data source: Federal statistical office (Destatis)",
                              decimal_mark = "."),
        "Import Germany_en", EN)
    }
  ),

  list(
    id = "trade_export_germany_real", category = "Trade",
    label = "Germany Real Exports (VGR national accounts)",
    spec  = "src/graphs/trade/trade_germany_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_export_germany_real("Reale Ausfuhren (Kettenindex 2020=100)",
                                   "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "Export Germany real VGR_ger", GER)
      render_graph(
        trade_export_germany_real("Real Exports (Chain Index 2020=100)",
                                   "Data source: Federal statistical office (Destatis)",
                                   decimal_mark = "."),
        "Export Germany real VGR_en", EN)
    }
  ),

  list(
    id = "trade_import_germany_real", category = "Trade",
    label = "Germany Real Imports (VGR national accounts)",
    spec  = "src/graphs/trade/trade_germany_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_import_germany_real("Reale Einfuhren (Kettenindex 2020=100)",
                                   "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "Import Germany real VGR_ger", GER)
      render_graph(
        trade_import_germany_real("Real Imports (Chain Index 2020=100)",
                                   "Data source: Federal statistical office (Destatis)",
                                   decimal_mark = "."),
        "Import Germany real VGR_en", EN)
    }
  ),

  list(
    id = "trade_export_lowersaxony", category = "Trade",
    label = "Lower Saxony Exports (total)",
    spec  = "src/graphs/trade/trade_state_bars.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_export_lowersaxony("Exporte (in Mrd. EUR)",
                                  "Datenquelle: Statistisches Bundesamt (Destatis)",
                                  decimal_mark = ","),
        "Export Lower Saxony_ger", GER)
      render_graph(
        trade_export_lowersaxony("Exports (in Billion EUR)",
                                  "Data source: Federal statistical office (Destatis)",
                                  decimal_mark = "."),
        "Export Lower Saxony_en", EN)
    }
  ),

  list(
    id = "trade_import_lowersaxony", category = "Trade",
    label = "Lower Saxony Imports (total)",
    spec  = "src/graphs/trade/trade_state_bars.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_import_lowersaxony("Importe (in Mrd. EUR)",
                                  "Datenquelle: Statistisches Bundesamt (Destatis)",
                                  decimal_mark = ","),
        "Import Lower Saxony_ger", GER)
      render_graph(
        trade_import_lowersaxony("Imports (in Billion EUR)",
                                  "Data source: Federal statistical office (Destatis)",
                                  decimal_mark = "."),
        "Import Lower Saxony_en", EN)
    }
  ),

  list(
    id = "trade_world_exports", category = "Trade",
    label = "World Exports of Goods and Services (WDI)",
    spec  = "src/graphs/trade/world_exports.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_world_exports("Weltexporte (in Mrd. 2015 US$)",
                             "Datenquelle: Nationale Statistik der Weltbank und OECD",
                             decimal_mark = ",", big_mark = "."),
        "W Exports of Goods and Services real_ger", GER)
      render_graph(
        trade_world_exports("World Exports (in Billion 2015 US$)",
                             "Data Source: World Bank National Accounts Data, and OECD National Accounts Data Files",
                             big_mark = ","),
        "W Exports of Goods and Services real_en", EN)
    }
  ),

  list(
    id = "trade_export_germany_pie", category = "Trade",
    label = "Germany Export Structure (pie)",
    spec  = "src/graphs/trade/trade_state_pies.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.integer(format(Sys.Date(), "%Y")) - 1
      render_graph(
        trade_export_germany_pie("Datenquelle: Statistisches Bundesamt (Destatis)"),
        paste0("Germany's Export Structure in ", yr, " pie_ger"), GER,
        width = 9, height = 7, dpi = 400)
      render_graph(
        trade_export_germany_pie("Data source: Federal statistical office (Destatis)",
                                  big_mark = ",", decimal_mark = "."),
        paste0("Germany's Export Structure in ", yr, " pie_en"), EN,
        width = 9, height = 7, dpi = 400)
    }
  ),

  list(
    id = "trade_import_germany_pie", category = "Trade",
    label = "Germany Import Structure (pie)",
    spec  = "src/graphs/trade/trade_state_pies.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.integer(format(Sys.Date(), "%Y")) - 1
      render_graph(
        trade_import_germany_pie("Datenquelle: Statistisches Bundesamt (Destatis)"),
        paste0("Germany's Import Structure in ", yr, " pie_ger"), GER,
        width = 9, height = 7, dpi = 400)
      render_graph(
        trade_import_germany_pie("Data source: Federal statistical office (Destatis)",
                                  big_mark = ",", decimal_mark = "."),
        paste0("Germany's Import Structure in ", yr, " pie_en"), EN,
        width = 9, height = 7, dpi = 400)
    }
  ),

  list(
    id = "trade_export_hamburg_pie", category = "Trade",
    label = "Hamburg Export Structure (pie)",
    spec  = "src/graphs/trade/trade_state_pies.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.integer(format(Sys.Date(), "%Y")) - 1
      render_graph(
        trade_export_hamburg_pie("Datenquelle: Statistisches Bundesamt (Destatis)"),
        paste0("Hamburg's Export Structure in ", yr, " pie_ger"), GER,
        width = 9, height = 5.5, dpi = 400)
      render_graph(
        trade_export_hamburg_pie("Data source: Federal statistical office (Destatis)",
                                  big_mark = ",", decimal_mark = "."),
        paste0("Hamburg's Export Structure in ", yr, " pie_en"), EN,
        width = 9, height = 5.5, dpi = 400)
    }
  ),

  list(
    id = "trade_import_hamburg_pie", category = "Trade",
    label = "Hamburg Import Structure (pie)",
    spec  = "src/graphs/trade/trade_state_pies.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.integer(format(Sys.Date(), "%Y")) - 1
      render_graph(
        trade_import_hamburg_pie("Datenquelle: Statistisches Bundesamt (Destatis)"),
        paste0("Hamburg's Import Structure in ", yr, " pie_ger"), GER,
        width = 9, height = 5.5, dpi = 400)
      render_graph(
        trade_import_hamburg_pie("Data source: Federal statistical office (Destatis)",
                                  big_mark = ",", decimal_mark = "."),
        paste0("Hamburg's Import Structure in ", yr, " pie_en"), EN,
        width = 9, height = 5.5, dpi = 400)
    }
  ),

  list(
    id = "trade_export_lowersaxony_pie", category = "Trade",
    label = "Lower Saxony Export Structure (pie)",
    spec  = "src/graphs/trade/trade_state_pies.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.integer(format(Sys.Date(), "%Y")) - 1
      render_graph(
        trade_export_lowersaxony_pie("Datenquelle: Statistisches Bundesamt (Destatis)"),
        paste0("Lower Saxony's Export Structure in ", yr, " pie_ger"), GER,
        width = 9, height = 5.5, dpi = 400)
      render_graph(
        trade_export_lowersaxony_pie("Data source: Federal statistical office (Destatis)",
                                      big_mark = ",", decimal_mark = "."),
        paste0("Lower Saxony's Export Structure in ", yr, " pie_en"), EN,
        width = 9, height = 5.5, dpi = 400)
    }
  ),

  list(
    id = "trade_import_lowersaxony_pie", category = "Trade",
    label = "Lower Saxony Import Structure (pie)",
    spec  = "src/graphs/trade/trade_state_pies.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.integer(format(Sys.Date(), "%Y")) - 1
      render_graph(
        trade_import_lowersaxony_pie("Datenquelle: Statistisches Bundesamt (Destatis)"),
        paste0("Lower Saxony's Import Structure in ", yr, " pie_ger"), GER,
        width = 9, height = 5.5, dpi = 400)
      render_graph(
        trade_import_lowersaxony_pie("Data source: Federal statistical office (Destatis)",
                                      big_mark = ",", decimal_mark = "."),
        paste0("Lower Saxony's Import Structure in ", yr, " pie_en"), EN,
        width = 9, height = 5.5, dpi = 400)
    }
  ),

  list(
    id = "trade_export_hamburg_country", category = "Trade",
    label = "Hamburg Exports by Country (choropleth)",
    spec  = "src/graphs/trade/trade_country_choropleths.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_export_hamburg_country("Exporte Hamburgs nach Ländern (in Mio. EUR)",
                                      "Datenquelle: Statistisches Bundesamt (Destatis)",
                                      year = yr),
        paste0("Hamburg Export by Country ", yr, "_ger"), GER)
      render_graph(
        trade_export_hamburg_country("Hamburg Exports by Country (in Mio. EUR)",
                                      "Data source: Federal statistical office (Destatis)",
                                      year = yr),
        paste0("Hamburg Export by Country ", yr, "_en"), EN)
    }
  ),

  list(
    id = "trade_import_hamburg_country", category = "Trade",
    label = "Hamburg Imports by Country (choropleth)",
    spec  = "src/graphs/trade/trade_country_choropleths.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_import_hamburg_country("Importe Hamburgs nach Ländern (in Mio. EUR)",
                                      "Datenquelle: Statistisches Bundesamt (Destatis)",
                                      year = yr),
        paste0("Hamburg Import by Country ", yr, "_ger"), GER)
      render_graph(
        trade_import_hamburg_country("Hamburg Imports by Country (in Mio. EUR)",
                                      "Data source: Federal statistical office (Destatis)",
                                      year = yr),
        paste0("Hamburg Import by Country ", yr, "_en"), EN)
    }
  ),

  list(
    id = "trade_export_lowersaxony_country", category = "Trade",
    label = "Lower Saxony Exports by Country (choropleth)",
    spec  = "src/graphs/trade/trade_country_choropleths.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_export_lowersaxony_country("Exporte Niedersachsens nach Ländern (in Mio. EUR)",
                                          "Datenquelle: Statistisches Bundesamt (Destatis)",
                                          year = yr),
        paste0("Lower Saxony Export by Country ", yr, "_ger"), GER)
      render_graph(
        trade_export_lowersaxony_country("Lower Saxony Exports by Country (in Mio. EUR)",
                                          "Data source: Federal statistical office (Destatis)",
                                          year = yr),
        paste0("Lower Saxony Export by Country ", yr, "_en"), EN)
    }
  ),

  list(
    id = "trade_import_lowersaxony_country", category = "Trade",
    label = "Lower Saxony Imports by Country (choropleth)",
    spec  = "src/graphs/trade/trade_country_choropleths.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_import_lowersaxony_country("Importe Niedersachsens nach Ländern (in Mio. EUR)",
                                          "Datenquelle: Statistisches Bundesamt (Destatis)",
                                          year = yr),
        paste0("Lower Saxony Import by Country ", yr, "_ger"), GER)
      render_graph(
        trade_import_lowersaxony_country("Lower Saxony Imports by Country (in Mio. EUR)",
                                          "Data source: Federal statistical office (Destatis)",
                                          year = yr),
        paste0("Lower Saxony Import by Country ", yr, "_en"), EN)
    }
  ),

  list(
    id = "trade_export_germany_country", category = "Trade",
    label = "Germany Exports by Country (choropleth)",
    spec  = "src/graphs/trade/trade_country_choropleths.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_export_germany_country("Ausfuhren nach Ländern (in Mio. EUR)",
                                      "Datenquelle: Statistisches Bundesamt (Destatis)",
                                      year = yr),
        paste0("Germany Export by Country ", yr, "_ger"), GER)
      render_graph(
        trade_export_germany_country("Germany Exports by Country (in Mio. EUR)",
                                      "Data source: Federal statistical office (Destatis)",
                                      year = yr),
        paste0("Germany Export by Country ", yr, "_en"), EN)
    }
  ),

  list(
    id = "trade_import_germany_country", category = "Trade",
    label = "Germany Imports by Country (choropleth)",
    spec  = "src/graphs/trade/trade_country_choropleths.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_import_germany_country("Einfuhren nach Ländern (in Mio. EUR)",
                                      "Datenquelle: Statistisches Bundesamt (Destatis)",
                                      year = yr),
        paste0("Germany Import by Country ", yr, "_ger"), GER)
      render_graph(
        trade_import_germany_country("Germany Imports by Country (in Mio. EUR)",
                                      "Data source: Federal statistical office (Destatis)",
                                      year = yr),
        paste0("Germany Import by Country ", yr, "_en"), EN)
    }
  ),

  list(
    id = "trade_hh_export_deviation_group", category = "Trade",
    label = "Hamburg vs Germany: Export Structure by Commodity Group",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_hh_export_deviation_group(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        "HH vs GER Export Structure Deviation by Group_ger", GER, height = 10)
      render_graph(
        trade_hh_export_deviation_group(
          caption        = "Data source: Federal statistical office (Destatis)",
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        "HH vs GER Export Structure Deviation by Group_en", EN, height = 10)
    }
  ),

  list(
    id = "trade_hh_import_deviation_group", category = "Trade",
    label = "Hamburg vs Germany: Import Structure by Commodity Group",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_hh_import_deviation_group(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        "HH vs GER Import Structure Deviation by Group_ger", GER, height = 10)
      render_graph(
        trade_hh_import_deviation_group(
          caption        = "Data source: Federal statistical office (Destatis)",
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        "HH vs GER Import Structure Deviation by Group_en", EN, height = 10)
    }
  ),

  list(
    id = "trade_ls_export_deviation_group", category = "Trade",
    label = "Lower Saxony vs Germany: Export Structure by Commodity Group",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_ls_export_deviation_group(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          positive_label = "LS überrepräsentiert",
          negative_label = "LS unterrepräsentiert",
          decimal_mark   = ","),
        "LS vs GER Export Structure Deviation by Group_ger", GER, height = 10)
      render_graph(
        trade_ls_export_deviation_group(
          caption        = "Data source: Federal statistical office (Destatis)",
          positive_label = "LS over-represented",
          negative_label = "LS under-represented",
          decimal_mark   = "."),
        "LS vs GER Export Structure Deviation by Group_en", EN, height = 10)
    }
  ),

  list(
    id = "trade_ls_import_deviation_group", category = "Trade",
    label = "Lower Saxony vs Germany: Import Structure by Commodity Group",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_ls_import_deviation_group(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          positive_label = "LS überrepräsentiert",
          negative_label = "LS unterrepräsentiert",
          decimal_mark   = ","),
        "LS vs GER Import Structure Deviation by Group_ger", GER, height = 10)
      render_graph(
        trade_ls_import_deviation_group(
          caption        = "Data source: Federal statistical office (Destatis)",
          positive_label = "LS over-represented",
          negative_label = "LS under-represented",
          decimal_mark   = "."),
        "LS vs GER Import Structure Deviation by Group_en", EN, height = 10)
    }
  ),

  list(
    id = "trade_hh_export_topbottom_country", category = "Trade",
    label = "Hamburg Top Export Partners (pp deviation vs Germany)",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_hh_export_topbottom_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        paste0("Hamburg Top Export Partners ", yr, "_ger"), GER, height = 7)
      render_graph(
        trade_hh_export_topbottom_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        paste0("Hamburg Top Export Partners ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_hh_import_topbottom_country", category = "Trade",
    label = "Hamburg Top Import Partners (pp deviation vs Germany)",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_hh_import_topbottom_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        paste0("Hamburg Top Import Partners ", yr, "_ger"), GER, height = 7)
      render_graph(
        trade_hh_import_topbottom_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        paste0("Hamburg Top Import Partners ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_ls_export_topbottom_country", category = "Trade",
    label = "Lower Saxony Top Export Partners (pp deviation vs Germany)",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_ls_export_topbottom_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "LS überrepräsentiert",
          negative_label = "LS unterrepräsentiert",
          decimal_mark   = ","),
        paste0("Lower Saxony Top Export Partners ", yr, "_ger"), GER, height = 7)
      render_graph(
        trade_ls_export_topbottom_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "LS over-represented",
          negative_label = "LS under-represented",
          decimal_mark   = "."),
        paste0("Lower Saxony Top Export Partners ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_ls_import_topbottom_country", category = "Trade",
    label = "Lower Saxony Top Import Partners (pp deviation vs Germany)",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        trade_ls_import_topbottom_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "LS überrepräsentiert",
          negative_label = "LS unterrepräsentiert",
          decimal_mark   = ","),
        paste0("Lower Saxony Top Import Partners ", yr, "_ger"), GER, height = 7)
      render_graph(
        trade_ls_import_topbottom_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "LS over-represented",
          negative_label = "LS under-represented",
          decimal_mark   = "."),
        paste0("Lower Saxony Top Import Partners ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_hh_export_yoy_change", category = "Trade",
    label = "Hamburg Monthly Exports: Year-on-Year Change",
    spec  = "src/graphs/trade/hh_export_yoy_change.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_export_yoy_change("Veränderung gg. Vorjahr (in %)",
                              "Datenquelle: Statistisches Bundesamt (Destatis)",
                              labels = c("Gesamtexporte", "Exporte ohne Luft- und Raumfahrzeuge")),
        "Hamburg Monthly Exports YoY Change_ger", GER)
      render_graph(
        hh_export_yoy_change("Change vs. prev. year (in %)",
                              "Data source: Federal statistical office (Destatis)",
                              labels = c("Total Exports", "Exports excl. Aircraft"),
                              decimal_mark = "."),
        "Hamburg Monthly Exports YoY Change_en", EN)
    }
  ),

  list(
    id = "trade_hh_import_yoy_change", category = "Trade",
    label = "Hamburg Monthly Imports: Year-on-Year Change",
    spec  = "src/graphs/trade/hh_import_yoy_change.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_import_yoy_change("Veränderung gg. Vorjahr (in %)",
                              "Datenquelle: Statistisches Bundesamt (Destatis)",
                              labels = c("Gesamteinfuhren", "Einfuhren ohne Luft- und Raumfahrzeuge")),
        "Hamburg Monthly Imports YoY Change_ger", GER)
      render_graph(
        hh_import_yoy_change("Change vs. prev. year (in %)",
                              "Data source: Federal statistical office (Destatis)",
                              labels = c("Total Imports", "Imports excl. Aircraft"),
                              decimal_mark = "."),
        "Hamburg Monthly Imports YoY Change_en", EN)
    }
  ),

  list(
    id = "trade_ger_export_yoy_change", category = "Trade",
    label = "Germany Monthly Exports: Year-on-Year Change",
    spec  = "src/graphs/trade/ger_export_yoy_change.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ger_export_yoy_change("Veränderung gg. Vorjahresmonat (in Mrd. EUR)",
                               "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "Germany Monthly Exports YoY Change_ger", GER)
      render_graph(
        ger_export_yoy_change("Change vs. same month prev. year (in Billion EUR)",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = "."),
        "Germany Monthly Exports YoY Change_en", EN)
    }
  ),

  list(
    id = "trade_ger_import_yoy_change", category = "Trade",
    label = "Germany Monthly Imports: Year-on-Year Change",
    spec  = "src/graphs/trade/ger_import_yoy_change.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ger_import_yoy_change("Veränderung gg. Vorjahresmonat (in Mrd. EUR)",
                               "Datenquelle: Statistisches Bundesamt (Destatis)"),
        "Germany Monthly Imports YoY Change_ger", GER)
      render_graph(
        ger_import_yoy_change("Change vs. same month prev. year (in Billion EUR)",
                               "Data source: Federal statistical office (Destatis)",
                               decimal_mark = "."),
        "Germany Monthly Imports YoY Change_en", EN)
    }
  ),

  list(
    id = "trade_hh_export_pandemic", category = "Trade",
    label = "Hamburg Monthly Exports since COVID-19 Pandemic",
    spec  = "src/graphs/trade/hh_export_pandemic.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_export_pandemic("Exporte (in Mrd. EUR)",
                            "Datenquelle: Statistisches Bundesamt (Destatis)",
                            labels = c("Gesamtexporte", "Exporte ohne Luft- und Raumfahrzeuge"),
                            decimal_mark = ",", big_mark = "."),
        "Hamburg Total Exports since Pandemic_ger", GER)
      render_graph(
        hh_export_pandemic("Exports (in Billion EUR)",
                            "Data source: Federal statistical office (Destatis)",
                            labels = c("Total Exports", "Exports excl. Aircraft"),
                            decimal_mark = ".", big_mark = ","),
        "Hamburg Total Exports since Pandemic_en", EN)
    }
  ),

  list(
    id = "trade_commodity_imports_hamburg", category = "Trade",
    label = "Hamburg Monthly Imports by Commodity Group",
    spec  = "src/graphs/trade/commodity_imports_hamburg.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        commodity_imports_hamburg("Einfuhren (in Mrd. EUR)",
                                   "Datenquelle: Statistisches Bundesamt (Destatis)",
                                   labels = c(EGW669 = "Mineralölerzeugnisse",
                                              EGW518 = "Erdöl u. Erdgas",
                                              EGW522 = "Kupfererze",
                                              EGW646 = "Kupfer u. Kupferlegierungen"),
                                   decimal_mark = ",", big_mark = "."),
        "Hamburg Commodity Imports monthly_ger", GER)
      render_graph(
        commodity_imports_hamburg("Imports (in Billion EUR)",
                                   "Data source: Federal statistical office (Destatis)",
                                   labels = c(EGW669 = "Mineral oil products",
                                              EGW518 = "Petroleum oil and petroleum gases",
                                              EGW522 = "Copper ores",
                                              EGW646 = "Copper and copper alloys, incl. waste, scrap"),
                                   decimal_mark = ".", big_mark = ","),
        "Hamburg Commodity Imports monthly_en", EN)
    }
  ),

  # ── New specs added to match old reference output ──────────────────────────

  list(
    id = "trade_hh_import_pandemic", category = "Trade",
    label = "Hamburg Monthly Imports since COVID-19 Pandemic",
    spec  = "src/graphs/trade/hh_import_pandemic.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_import_pandemic("Einfuhren (in Mrd. EUR)",
                            "Datenquelle: Statistisches Bundesamt (Destatis)",
                            labels = c("Gesamteinfuhren", "Einfuhren ohne Luft- und Raumfahrzeuge"),
                            decimal_mark = ",", big_mark = "."),
        "Hamburg Total Imports since Pandemic_ger", GER)
      render_graph(
        hh_import_pandemic("Imports (in Billion EUR)",
                            "Data source: Federal statistical office (Destatis)",
                            labels = c("Total Imports", "Imports excl. Aircraft"),
                            decimal_mark = ".", big_mark = ","),
        "Hamburg Total Imports since Pandemic_en", EN)
    }
  ),

  list(
    id = "trade_export_germany_real_goods", category = "Trade",
    label = "Germany Real Exports of Goods (VGR)",
    spec  = "src/graphs/trade/trade_germany_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_export_germany_real_goods("Ausfuhren Güter (in Mrd. EUR, preisbereinigt)",
                                         "Datenquelle: Statistisches Bundesamt (Destatis)",
                                         decimal_mark = ","),
        "Export Goods Germany real VGR_ger", GER)
      render_graph(
        trade_export_germany_real_goods("Exports of Goods (in Billion EUR, price-adjusted)",
                                         "Data source: Federal statistical office (Destatis)",
                                         decimal_mark = "."),
        "Export Goods Germany real VGR_en", EN)
    }
  ),

  list(
    id = "trade_export_germany_real_services", category = "Trade",
    label = "Germany Real Exports of Services (VGR)",
    spec  = "src/graphs/trade/trade_germany_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_export_germany_real_services("Ausfuhren Dienstleistungen (in Mrd. EUR, preisbereinigt)",
                                            "Datenquelle: Statistisches Bundesamt (Destatis)",
                                            decimal_mark = ","),
        "Export Services Germany real VGR_ger", GER)
      render_graph(
        trade_export_germany_real_services("Exports of Services (in Billion EUR, price-adjusted)",
                                            "Data source: Federal statistical office (Destatis)",
                                            decimal_mark = "."),
        "Export Services Germany real VGR_en", EN)
    }
  ),

  list(
    id = "trade_import_germany_real_goods", category = "Trade",
    label = "Germany Real Imports of Goods (VGR)",
    spec  = "src/graphs/trade/trade_germany_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_import_germany_real_goods("Einfuhren Güter (in Mrd. EUR, preisbereinigt)",
                                         "Datenquelle: Statistisches Bundesamt (Destatis)",
                                         decimal_mark = ","),
        "Import Goods Germany real VGR_ger", GER)
      render_graph(
        trade_import_germany_real_goods("Imports of Goods (in Billion EUR, price-adjusted)",
                                         "Data source: Federal statistical office (Destatis)",
                                         decimal_mark = "."),
        "Import Goods Germany real VGR_en", EN)
    }
  ),

  list(
    id = "trade_import_germany_real_services", category = "Trade",
    label = "Germany Real Imports of Services (VGR)",
    spec  = "src/graphs/trade/trade_germany_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        trade_import_germany_real_services("Einfuhren Dienstleistungen (in Mrd. EUR, preisbereinigt)",
                                            "Datenquelle: Statistisches Bundesamt (Destatis)",
                                            decimal_mark = ","),
        "Import Services Germany real VGR_ger", GER)
      render_graph(
        trade_import_germany_real_services("Imports of Services (in Billion EUR, price-adjusted)",
                                            "Data source: Federal statistical office (Destatis)",
                                            decimal_mark = "."),
        "Import Services Germany real VGR_en", EN)
    }
  ),

  list(
    id = "trade_ger_export_nominal_real", category = "Trade",
    label = "Germany Export Development: Nominal vs Real",
    spec  = "src/graphs/trade/ger_export_development_nominal_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ger_export_development_nominal_real(
          "Ausfuhren (in Mrd. EUR)",
          "Datenquelle: Statistisches Bundesamt (Destatis)",
          labels = c(Nominal = "Nominale Ausfuhren", Real = "Reale Ausfuhren (VGR)"),
          decimal_mark = ","),
        "GER Export Development - Nominal vs Real_ger", GER)
      render_graph(
        ger_export_development_nominal_real(
          "Exports (in Billion EUR)",
          "Data source: Federal statistical office (Destatis)",
          labels = c(Nominal = "Nominal exports", Real = "Real exports (VGR)"),
          decimal_mark = "."),
        "GER Export Development - Nominal vs Real_en", EN)
    }
  ),

  list(
    id = "trade_ger_import_nominal_real", category = "Trade",
    label = "Germany Import Development: Nominal vs Real",
    spec  = "src/graphs/trade/ger_export_development_nominal_real.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ger_import_development_nominal_real(
          "Einfuhren (in Mrd. EUR)",
          "Datenquelle: Statistisches Bundesamt (Destatis)",
          labels = c(Nominal = "Nominale Einfuhren", Real = "Reale Einfuhren (VGR)"),
          decimal_mark = ","),
        "GER Import Development - Nominal vs Real_ger", GER)
      render_graph(
        ger_import_development_nominal_real(
          "Imports (in Billion EUR)",
          "Data source: Federal statistical office (Destatis)",
          labels = c(Nominal = "Nominal imports", Real = "Real imports (VGR)"),
          decimal_mark = "."),
        "GER Import Development - Nominal vs Real_en", EN)
    }
  ),

  list(
    id = "trade_commodity_imports_germany", category = "Trade",
    label = "Germany Monthly Imports by Commodity Group",
    spec  = "src/graphs/trade/commodity_imports_germany.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        commodity_imports_germany("Einfuhren (in Mrd. EUR)",
                                   "Datenquelle: Statistisches Bundesamt (Destatis)",
                                   labels = c(EGW669 = "Mineralölerzeugnisse",
                                              EGW518 = "Erdöl u. Erdgas",
                                              EGW522 = "Kupfererze",
                                              EGW646 = "Kupfer u. Kupferlegierungen"),
                                   decimal_mark = ",", big_mark = "."),
        "Germany Commodity Imports monthly_ger", GER)
      render_graph(
        commodity_imports_germany("Imports (in Billion EUR)",
                                   "Data source: Federal statistical office (Destatis)",
                                   labels = c(EGW669 = "Mineral oil products",
                                              EGW518 = "Petroleum oil and petroleum gases",
                                              EGW522 = "Copper ores",
                                              EGW646 = "Copper and copper alloys, incl. waste, scrap"),
                                   decimal_mark = ".", big_mark = ","),
        "Germany Commodity Imports monthly_en", EN)
    }
  ),

  list(
    id = "employment_short_time", category = "Employment",
    label = "Germany Short-Time Work and Unemployment Rate",
    spec  = "src/graphs/employment/ger_short_time_employment.R",
    render = function() {
      GER <- file.path(OUT_DIR, "employment graphs/German labeling")
      EN  <- file.path(OUT_DIR, "employment graphs/English labeling")
      render_graph(
        ger_short_time_employment(
          "Datenquelle: Statistisches Bundesamt (Destatis)",
          label_kurzarbeit   = "Kurzarbeiter",
          label_unemployment = "Arbeitslosenquote",
          y_axis_left        = "Kurzarbeiter (in Tsd.)",
          y_axis_right       = "Arbeitslosenquote in %",
          decimal_mark       = ",",
          y_max_right        = 15),
        "GER unemployed rate and short term employee_ger", GER)
      render_graph(
        ger_short_time_employment(
          "Data source: Federal statistical office (Destatis)",
          label_kurzarbeit   = "Short-time workers",
          label_unemployment = "Unemployment rate",
          y_axis_left        = "Short-time workers (in thousands)",
          y_axis_right       = "Unemployment rate in %",
          decimal_mark       = ".",
          y_max_right        = 15),
        "GER unemployed rate and short term employee_en", EN)
    }
  ),

  # ── GDP: new charts ──────────────────────────────────────────────────────────

  list(
    id = "ger_bip_quarterly_volume_orig", category = "GDP",
    label = "Germany Quarterly GDP - Chain-linked Volume (Mrd EUR, original)",
    spec  = "src/graphs/gdp/ger_bip_quarterly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_quarterly_volume_orig("BIP (in Mrd. EUR, verkettete Volumen, Originalwerte)",
                                      "Datenquelle: Statistisches Bundesamt (Destatis)",
                                      decimal_mark = ",", big_mark = "."),
        "GER BIP quarterly - chain-linked volume data (bn EUR)_ger", GER)
      render_graph(
        ger_bip_quarterly_volume_orig("GDP (in Billion EUR, chain-linked volume, original)",
                                      "Data source: Federal statistical office (Destatis)",
                                      decimal_mark = ".", big_mark = ","),
        "GER BIP quarterly - chain-linked volume data (bn EUR)_en", EN)
    }
  ),

  list(
    id = "ger_bip_quarterly_volume", category = "GDP",
    label = "Germany Quarterly GDP - Chain-linked Volume (Mrd EUR, SA)",
    spec  = "src/graphs/gdp/ger_bip_quarterly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "GDP graphs/German labeling")
      EN  <- file.path(OUT_DIR, "GDP graphs/English labeling")
      render_graph(
        ger_bip_quarterly_volume("BIP (in Mrd. EUR, verkettete Volumen, saisonbereinigt)",
                                  "Datenquelle: Statistisches Bundesamt (Destatis)",
                                  decimal_mark = ",", big_mark = "."),
        "GER BIP quarterly volume_ger", GER)
      render_graph(
        ger_bip_quarterly_volume("GDP (in Billion EUR, chain-linked volume, seasonally adjusted)",
                                  "Data source: Federal statistical office (Destatis)",
                                  decimal_mark = ".", big_mark = ","),
        "GER BIP quarterly volume_en", EN)
    }
  ),

  # ── Trade: new monthly level charts ─────────────────────────────────────────

  list(
    id = "hh_export_monthly", category = "Trade",
    label = "Hamburg Monthly Exports by Value (with/without aircraft)",
    spec  = "src/graphs/trade/hh_export_monthly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_export_monthly("Exporte (in Mrd. EUR)",
                           "Datenquelle: Statistisches Bundesamt (Destatis)",
                           labels = c("Gesamtexporte", "Exporte ohne Luft- und Raumfahrzeuge"),
                           decimal_mark = ","),
        "HH Export - value_ger", GER)
      render_graph(
        hh_export_monthly("Exports (in Billion EUR)",
                           "Data source: Federal statistical office (Destatis)",
                           labels = c("Total Exports", "Exports excl. Aircraft"),
                           decimal_mark = "."),
        "HH Export - value_en", EN)
    }
  ),

  list(
    id = "hh_import_monthly", category = "Trade",
    label = "Hamburg Monthly Imports by Value (with/without aircraft)",
    spec  = "src/graphs/trade/hh_import_monthly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_import_monthly("Importe (in Mrd. EUR)",
                           "Datenquelle: Statistisches Bundesamt (Destatis)",
                           labels = c("Gesamteinfuhren", "Einfuhren ohne Luft- und Raumfahrzeuge"),
                           decimal_mark = ","),
        "HH Import - value_ger", GER)
      render_graph(
        hh_import_monthly("Imports (in Billion EUR)",
                           "Data source: Federal statistical office (Destatis)",
                           labels = c("Total Imports", "Imports excl. Aircraft"),
                           decimal_mark = "."),
        "HH Import - value_en", EN)
    }
  ),

  list(
    id = "ger_export_goods_monthly", category = "Trade",
    label = "Germany Monthly Goods Exports - Level (Mrd EUR)",
    spec  = "src/graphs/trade/ger_export_goods_monthly.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ger_export_goods_monthly("Güterausfuhren (in Mrd. EUR)",
                                  "Datenquelle: Statistisches Bundesamt (Destatis)",
                                  decimal_mark = ",", big_mark = "."),
        "GER Export goods monthly level_ger", GER)
      render_graph(
        ger_export_goods_monthly("Goods Exports (in Billion EUR)",
                                  "Data source: Federal statistical office (Destatis)",
                                  decimal_mark = ".", big_mark = ","),
        "GER Export goods monthly level_en", EN)
    }
  ),

  # ── Prices: ECB deposit rate + CPI ──────────────────────────────────────────

  list(
    id = "ger_interest_rate_cpi", category = "Prices",
    label = "Germany: ECB Deposit Rate and Inflation Rate",
    spec  = "src/graphs/prices/ger_interest_rate_cpi.R",
    render = function() {
      GER <- file.path(OUT_DIR, "prices graphs/German labeling")
      EN  <- file.path(OUT_DIR, "prices graphs/English labeling")
      render_graph(
        ger_interest_rate_cpi(
          caption          = "Datenquelle: EZB / FRED, Statistisches Bundesamt (Destatis)",
          label_rate       = "EZB-Einlagenzins",
          label_inflation  = "Inflationsrate",
          y_axis_left      = "EZB-Einlagenzins (in %)",
          y_axis_right     = "Inflationsrate (in %)",
          decimal_mark     = ","),
        "GER ECB rate and inflation_ger", GER)
      render_graph(
        ger_interest_rate_cpi(
          caption          = "Data source: ECB / FRED, Federal statistical office (Destatis)",
          label_rate       = "ECB deposit rate",
          label_inflation  = "Inflation rate",
          y_axis_left      = "ECB deposit rate (in %)",
          y_axis_right     = "Inflation rate (in %)",
          decimal_mark     = "."),
        "GER ECB rate and inflation_en", EN)
    }
  ),

  # ── Prices: Survey – ECB/FED interest rates + German CPI ────────────────────

  list(
    id = "ger_survey_interest_cpi", category = "Prices",
    label = "Survey on Development of Interest Rates and German Consumer Price Index",
    spec  = "src/graphs/prices/ger_survey_interest_cpi.R",
    render = function() {
      GER <- file.path(OUT_DIR, "prices graphs/German labeling")
      EN  <- file.path(OUT_DIR, "prices graphs/English labeling")
      render_graph(
        ger_survey_interest_cpi(
          caption        = "Datenquelle: Destatis, Deutsche Bundesbank, Federal Reserve System (US)",
          label_band     = "Zinsbandbreite",
          label_effr     = "Effektiver Tagesgeldsatz (USA)",
          label_ecb_main = "EZB-Hauptrefinanzierungssatz",
          label_cpi      = "Verbraucherpreisindex",
          y_axis_left    = "Zinssatz in %",
          y_axis_right   = "Veränderung Verbraucherpreisindex zum Vorjahresmonat in %",
          decimal_mark   = ","),
        "Survey on development of interest rate and german consumer-pric-index_ger", GER)
      render_graph(
        ger_survey_interest_cpi(
          caption        = "Data source: Destatis, German Federal Bank, Board of Governors of the Federal Reserve System (US)",
          label_band     = "Interest rate band",
          label_effr     = "Effektive Federal Funds rate",
          label_ecb_main = "ECB interest rate for main refinancing operations",
          label_cpi      = "Consumer price index",
          y_axis_left    = "Interest rate in %",
          y_axis_right   = "Change of consumer price index to previous year's month in %",
          decimal_mark   = "."),
        "Survey on development of interest rate and german consumer-pric-index_en", EN)
    }
  ),

  list(
    id = "ger_interest_rate_hpi_dax", category = "Prices",
    label = "Development of Interest Rates, House Price Index and DAX",
    spec  = "src/graphs/prices/ger_interest_rate_hpi_dax.R",
    render = function() {
      GER <- file.path(OUT_DIR, "prices graphs/German labeling")
      EN  <- file.path(OUT_DIR, "prices graphs/English labeling")
      render_graph(
        ger_interest_rate_hpi_dax(
          caption      = "Datenquelle: Destatis, Deutsche Bundesbank, Yahoo Finance",
          label_band   = "Zinsband",
          label_ecb    = "Hauptrefinanzierungssatz der EZB",
          label_hpi    = "Häuserpreisindex",
          label_dax    = "DAX",
          y_axis_left  = "Zinssatz in %",
          y_axis_right = "Indexwert (Start = 100)",
          decimal_mark = ","),
        "Development of interest rates, german house-price-index and dax index_ger", GER)
      render_graph(
        ger_interest_rate_hpi_dax(
          caption      = "Data source: Destatis, German Federal Bank, Yahoo Finance",
          label_band   = "Interest rate band",
          label_ecb    = "ECB interest rate for main refinancing operations",
          label_hpi    = "House price index",
          label_dax    = "DAX",
          y_axis_left  = "Interest rate in %",
          y_axis_right = "Index value (Start = 100)",
          decimal_mark = "."),
        "Development of interest rates, german house-price-index and dax index_en", EN)
    }
  ),

  # ── Trade: state vs Germany deviation by country ─────────────────────────────

  list(
    id = "trade_hh_export_deviation_country_map", category = "Trade",
    label = "HH Export - Deviations from German Average (by category)",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        hh_export_deviation_country_map(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        paste0("HH Export - Deviations from German Average ", yr, "_ger"), GER, height = 7)
      render_graph(
        hh_export_deviation_country_map(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        paste0("HH Export - Deviations from German Average ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_hh_import_deviation_country_map", category = "Trade",
    label = "HH Import - Deviations from German Average (by category)",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        hh_import_deviation_country_map(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        paste0("HH Import - Deviations from German Average ", yr, "_ger"), GER, height = 7)
      render_graph(
        hh_import_deviation_country_map(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        paste0("HH Import - Deviations from German Average ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_hh_export_deviation_country", category = "Trade",
    label = "HH Export - Deviations from German Average by Country",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        hh_export_deviation_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        paste0("HH Export - Deviations from German Average by Country ", yr, "_ger"), GER, height = 7)
      render_graph(
        hh_export_deviation_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        paste0("HH Export - Deviations from German Average by Country ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_hh_import_deviation_country", category = "Trade",
    label = "HH Import - Deviations from German Average by Country",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        hh_import_deviation_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "HH überrepräsentiert",
          negative_label = "HH unterrepräsentiert",
          decimal_mark   = ","),
        paste0("HH Import - Deviations from German Average by Country ", yr, "_ger"), GER, height = 7)
      render_graph(
        hh_import_deviation_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "HH over-represented",
          negative_label = "HH under-represented",
          decimal_mark   = "."),
        paste0("HH Import - Deviations from German Average by Country ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_hh_export_comparison_country_2025", category = "Trade",
    label = "Hamburg vs Germany Export Share Comparison by Country in 2025",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_export_deviation_choropleth("Exportanteil HH minus Deutschland (in Pp.)",
                                        "Datenquelle: Statistisches Bundesamt (Destatis)",
                                        year = 2025),
        "Hamburg vs Germany Export Share Comparison by Country in 2025_ger", GER)
      render_graph(
        hh_export_deviation_choropleth("HH export share minus Germany (in pp.)",
                                        "Data source: Federal statistical office (Destatis)",
                                        year = 2025),
        "Hamburg vs Germany Export Share Comparison by Country in 2025_en", EN)
    }
  ),

  list(
    id = "trade_hh_import_comparison_country_2025", category = "Trade",
    label = "Hamburg vs Germany Import Share Comparison by Country in 2025",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        hh_import_deviation_choropleth("Importanteil HH minus Deutschland (in Pp.)",
                                        "Datenquelle: Statistisches Bundesamt (Destatis)",
                                        year = 2025),
        "Hamburg vs Germany Import Share Comparison by Country in 2025_ger", GER)
      render_graph(
        hh_import_deviation_choropleth("HH import share minus Germany (in pp.)",
                                        "Data source: Federal statistical office (Destatis)",
                                        year = 2025),
        "Hamburg vs Germany Import Share Comparison by Country in 2025_en", EN)
    }
  ),

  list(
    id = "trade_ls_export_deviation_country", category = "Trade",
    label = "Lower Saxony Export - Deviations from German Average by Country",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        ls_export_deviation_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "LS überrepräsentiert",
          negative_label = "LS unterrepräsentiert",
          decimal_mark   = ","),
        paste0("LS Export - Deviations from German Average by Country ", yr, "_ger"), GER, height = 7)
      render_graph(
        ls_export_deviation_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "LS over-represented",
          negative_label = "LS under-represented",
          decimal_mark   = "."),
        paste0("LS Export - Deviations from German Average by Country ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_ls_import_deviation_country", category = "Trade",
    label = "Lower Saxony Import - Deviations from German Average by Country",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      yr  <- as.character(as.integer(format(Sys.Date(), "%Y")) - 1)
      render_graph(
        ls_import_deviation_country(
          caption        = "Datenquelle: Statistisches Bundesamt (Destatis)",
          year           = yr,
          positive_label = "LS überrepräsentiert",
          negative_label = "LS unterrepräsentiert",
          decimal_mark   = ","),
        paste0("LS Import - Deviations from German Average by Country ", yr, "_ger"), GER, height = 7)
      render_graph(
        ls_import_deviation_country(
          caption        = "Data source: Federal statistical office (Destatis)",
          year           = yr,
          positive_label = "LS over-represented",
          negative_label = "LS under-represented",
          decimal_mark   = "."),
        paste0("LS Import - Deviations from German Average by Country ", yr, "_en"), EN, height = 7)
    }
  ),

  list(
    id = "trade_ls_export_comparison_country_2025", category = "Trade",
    label = "Lower Saxony vs Germany Export Share Comparison by Country in 2025",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ls_export_deviation_choropleth("Exportanteil LS minus Deutschland (in Pp.)",
                                        "Datenquelle: Statistisches Bundesamt (Destatis)",
                                        year = 2025),
        "Lower Saxony vs Germany Export Share Comparison by Country in 2025_ger", GER)
      render_graph(
        ls_export_deviation_choropleth("LS export share minus Germany (in pp.)",
                                        "Data source: Federal statistical office (Destatis)",
                                        year = 2025),
        "Lower Saxony vs Germany Export Share Comparison by Country in 2025_en", EN)
    }
  ),

  list(
    id = "trade_ls_import_comparison_country_2025", category = "Trade",
    label = "Lower Saxony vs Germany Import Share Comparison by Country in 2025",
    spec  = "src/graphs/trade/trade_deviation.R",
    render = function() {
      GER <- file.path(OUT_DIR, "trade graphs/German labeling")
      EN  <- file.path(OUT_DIR, "trade graphs/English labeling")
      render_graph(
        ls_import_deviation_choropleth("Importanteil LS minus Deutschland (in Pp.)",
                                        "Datenquelle: Statistisches Bundesamt (Destatis)",
                                        year = 2025),
        "Lower Saxony vs Germany Import Share Comparison by Country in 2025_ger", GER)
      render_graph(
        ls_import_deviation_choropleth("LS import share minus Germany (in pp.)",
                                        "Data source: Federal statistical office (Destatis)",
                                        year = 2025),
        "Lower Saxony vs Germany Import Share Comparison by Country in 2025_en", EN)
    }
  ),

  list(
    id = "ger_govt_bond_yields", category = "Prices",
    label = "Long-Term Government Bond Yields: Top/Bottom 5 EU Countries (Eurostat)",
    spec  = "src/graphs/prices/ger_govt_bond_yields.R",
    render = function() {
      GER <- file.path(OUT_DIR, "prices graphs/German labeling")
      EN  <- file.path(OUT_DIR, "prices graphs/English labeling")
      cn_ger <- c(AT="Österreich", BE="Belgien", BG="Bulgarien", CY="Zypern",
                   CZ="Tschechien", DE="Deutschland", DK="Dänemark", EA="EU",
                   EE="Estland", EL="Griechenland", ES="Spanien", FI="Finnland",
                   FR="Frankreich", HR="Kroatien", HU="Ungarn", IE="Irland",
                   IT="Italien", LT="Litauen", LU="Luxemburg", LV="Lettland",
                   MT="Malta", NL="Niederlande", PL="Polen", PT="Portugal",
                   RO="Rumänien", SE="Schweden", SI="Slowenien", SK="Slowakei",
                   UK="Vereinigtes Königreich")
      cn_en  <- c(AT="Austria", BE="Belgium", BG="Bulgaria", CY="Cyprus",
                   CZ="Czechia", DE="Germany", DK="Denmark", EA="EU",
                   EE="Estonia", EL="Greece", ES="Spain", FI="Finland",
                   FR="France", HR="Croatia", HU="Hungary", IE="Ireland",
                   IT="Italy", LT="Lithuania", LU="Luxembourg", LV="Latvia",
                   MT="Malta", NL="Netherlands", PL="Poland", PT="Portugal",
                   RO="Romania", SE="Sweden", SI="Slovenia", SK="Slovakia",
                   UK="United Kingdom")
      render_graph(
        ger_govt_bond_yields(
          y_axis        = "Rendite (%)",
          caption       = "Datenquelle: Eurostat",
          decimal_mark  = ",",
          country_names = cn_ger),
        "Long term returns of top bottom 5 government bonds_ger", GER)
      render_graph(
        ger_govt_bond_yields(
          y_axis        = "Yield (%)",
          caption       = "Data source: Eurostat",
          decimal_mark  = ".",
          country_names = cn_en),
        "Long term returns of top bottom 5 government bonds_en", EN)
    }
  )
)
