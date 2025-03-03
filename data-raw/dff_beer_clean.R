library(dplyr)
library(ggplot2)
library(readr)
library(stringr)

# DATA PREP -- WILL LOAD THE CLEANED DATA
df <- read_csv("data-raw/dff_beer.csv") %>%
    filter(between(week, 91, 300 )) %>%
    filter(price != 0) %>%
    filter(brand %in% c("LOWENBRAU BEER NR BT", "BUDWEISER BEER", "CORONA EXTRA BEER NR", "MILLER GENUINE DRAFT"))

unique_brand_move <-
    df %>%
    # duplicate obs
    group_by(store, week, brand) %>%
    summarise(
        upc = min(upc),
        qty = sum(move),
        price = min(price),
        sales_indicator = any(grepl("S", sale))
    )

# add more data
stores <- read_csv("data-raw/dff_store_locations.csv")
week_info <- read_csv("data-raw/dff_week_dates.csv")

beer <- 
    unique_brand_move %>% 
    inner_join(stores, by = join_by(store == store_id)) %>%
    inner_join(week_info, by = join_by(week == week_id)) %>%
    mutate(is_holiday_week = !is.na(holiday_date)) %>%
    select(store:longtitude, start_of_week, is_holiday_week) %>%
    mutate(imported = case_when(
        brand %in% c("LOWENBRAU BEER NR BT", "CORONA EXTRA BEER NR") ~ "imported",
        brand %in% c("BUDWEISER BEER", "MILLER GENUINE DRAFT") ~ "domestic",
        TRUE ~ NA_character_  # For any other brands that might be in the dataset
    )) %>%
    mutate (
        brand = brand %>%
            # Remove "NR" and "BT" suffixes
            str_replace_all(" NR | NR$", " ") %>%
            str_replace_all(" BT | BT$", " ") %>%
            # Remove excess whitespace
            str_trim() %>%
            # Handle any double spaces that might result from the replacements
            str_squish() %>%
            # Extract only the first word
            word(1) %>%
            str_to_title()
    )

write_csv(beer, "data/beer.csv")