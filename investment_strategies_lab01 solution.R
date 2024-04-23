
###########################################################################
# Exercises 1                                                             #
###########################################################################

# Exercise 1.1
# Import quotations for three different companies (eg. MSFT, KO, PEP)
# from yahoo finance. Merge together all close prices into one xts
# object and plot them on one graph.

symbols <- c("SBUX", "MCD", "KO")
getSymbols(symbols, from = "2005-01-01")

# Merge close prices into one xts object
prices <- do.call(merge, lapply(symbols, function(sym) Cl(get(sym))))

# Plot the merged close prices
plot(prices, main = "Closing Prices", legend.loc = "topleft" , col = 1:length(symbols))

# Exercise 1.2
# Load truefx data for EURGBP from file named EURGBP-2023-08.csv.
# Data were downloaded by the lecturer from https://www.truefx.com.
# Signing up is required to get them directly.
eurgbp <- read.csv("data/EURGBP-2023-08.csv", header= FALSE)
head(eurgbp)

# CAUTION! There are no column names in the first row.
# Assign column names: symbol, date_time, bid, ask.
colnames(eurgbp) <- c( "symbol", "date_time", "bid", "ask")
head(eurgbp)
str(eurgbp)

# Create a correct date-time index.
eurgbp$date_time <- strptime(eurgbp$date_time, 
                             format = "%Y%m%d %H:%M:%OS",
                             tz = "GMT")

# Convert to xts.

eurgbp_xts <- xts(eurgbp[, c("bid", "ask")], order.by = eurgbp$date_time)


# Compare the size of a data.frame and xts object.
object_size(eurgbp)
object_size(eurgbp_xts)

# Play with different plots of the data.
plot(eurgbp_xts, main = "EURGBP Prices", col = c("blue", "red"), lwd = 2)
legend("topright", legend = c("Bid", "Ask"), col = c("blue", "red"), lwd = 2)

# Plot the xts dataset using plot.xts
plot.xts(eurgbp_xts, main = "EURGBP Bid and Ask Prices", plot.type = "single")

# Exercise 1.3
# Aggregate the data for EURGBP (from Exercise 1.2) to:
# - 15 sec data
eurgbp_15sec <- to.period(eurgbp_xts, period = "secs", k = 15)

# - 3 min data
eurgbp_3min <- to.period(eurgbp_xts, period = "minutes", k = 3)

# - 2 hourly data
eurgbp_2hour <- to.period(eurgbp_xts, period = "hours", k = 2)

