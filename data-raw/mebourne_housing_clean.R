library(dplyr)
library(readr)
library(stringr)

df <- 
    read_csv("data-raw/melbourne_housing_full.csv") %>%
    janitor::clean_names() %>%
    filter(between(price, 300e3, 2.5e6)) %>%
    filter(str_detect(regionname, "Metropolitan")) %>%
    mutate(
        # Rename region names for clarity
        regionname = case_when(
            regionname == "Northern Metropolitan" ~ "Northern Metro",
            regionname == "Southern Metropolitan" ~ "Southern Metro",
            regionname == "Western Metropolitan" ~ "Western Metro",
            regionname == "Eastern Metropolitan" ~ "Eastern Metro",
            regionname == "South-Eastern Metropolitan" ~ "South-East. Metro",
            TRUE ~ regionname  # Keep other values unchanged
        ),
        # Rename housing types with "Apartment" instead of "Unit"
        type = recode(type, 
                      "h" = "House",
                      "t" = "Townhouse",
                      "u" = "Apartment")
    )

write_csv(df, "data/melbourne_housing.csv")
