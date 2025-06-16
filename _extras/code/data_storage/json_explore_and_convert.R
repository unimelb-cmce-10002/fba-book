# streaming json
#install.packages("ndjson")  # if not already installed
library(ndjson)

# Read NDJSON file (each line = one auction)
auctions <- ndjson::stream_in("_extras/code/data_storage/output/ebay_auctions_large.ndjson")

# Peek
str(auctions)

library(jsonlite)
library(tibble)
library(dplyr)
library(tidyr)

# This preserves the nested structure as-is
# auctions_nested <- stream_in(file("_extras/code/data_storage/output/ebay_auctions_large.ndjson"),
#                                   simplifyDataFrame = FALSE
#                                   )
#                              
# auctions_nested[1]

auctions_nested <- read_json("_extras/code/data_storage/output/ebay_auctions_large.json")

# Look at one record
str(auctions_nested[[1]])

# Access top-level fields
auctions_nested[[1]]$item_id
auctions_nested[[1]]$seller$user_id
auctions_nested[[1]]$bids[[1]]$amount

# Wrap each auction record into a one-column tibble
auctions_tbl <- tibble(record = auctions_nested)

# now unnest the list
auctions_tbl <- auctions_tbl %>%
    unnest_wider(record)

auctions_tbl <- auctions_tbl %>%
    unnest_wider(seller, names_sep = "_")

# suppose we kept going wider
auctions_tbl_wide <- auctions_tbl %>%
    unnest_wider(bids, names_sep = "_")

auctions_tbl_wide <- auctions_tbl_wide %>%
    unnest_wider(bids_1, names_sep = "_",  names_repair = "unique") %>%
    unnest_wider(bids_2, names_sep = "_",  names_repair = "unique")
    
# if we wanted to do all programattically! tip box/ extension box
# Get all column names that start with "bids_" and are still list-columns
# bid_cols <- auctions_tbl_wide %>%
#     select(starts_with("bids_")) %>%
#     select(where(is.list)) %>%
#     names()
# 
# # Iteratively unnest each list-column
# auctions_tbl_wide <- reduce(
#     bid_cols,
#     .init = auctions_tbl_wide,
#     .f = function(df, col) {
#         unnest_wider(df, !!sym(col), names_sep = "_", names_repair = "unique")
#     }
# )

# unnesting longer
bids_long <- auctions_tbl %>%
    #select(item_id, bids) %>%
    unnest_longer(bids) %>%
    unnest_wider(bids)

# exercise to think about data structure: 
# Try this:
# bids_long %>%
#     group_by(item_id) %>%
#     summarise(max_bid = max(amount), n_bids = n())

# Now imagine doing that in the wide version...

# tip -- re-nesting
# re-nesting
bids_renested <- 
    bids_long %>%
    #select(item_id, bidder_id, amount, time) %>%
    group_by(item_id) %>%
    summarise(bids = list(cur_data()), .groups = "drop")

bids_renested <- bids_long %>%
    nest(bids = c(bidder_id, amount, time))

library(purrr)

# auctions_json_ready <- bids_renested %>%
#     mutate(bids = map(bids, ~ split(.x, seq(nrow(.x)))))

auctions_json_ready <- bids_renested %>%
    mutate(bids = map(bids, ~ unname(split(.x, seq(nrow(.x))))))

# write json to file
write_json(auctions_nested_final, "auctions_nested_roundtrip.json", auto_unbox = TRUE, pretty = TRUE)

# great -- thats all for json
