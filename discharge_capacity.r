

# Load required packages
library(dplyr)
library(ggplot2)
library(data.table)

# Read the discharge data from CSV file
library(readxl)
data <- read_excel("~/Downloads/test-battery-voltage.xlsx")

str(data)

# Basic data summary
summary(data)

# Plot voltage vs. time
ggplot(data, aes(x = data$`Test_Time(s)...1`, y = data$`Current(A)`)) +
  geom_line() +
  labs(title = "Battery Discharge",
       x = "Time (s)", y = "Voltage (V)")

# Calculate discharge capacity
discharge_capacity <- sum(data$voltage) * (data$time[2] - data$time[1])
cat("Discharge Capacity:", discharge_capacity, "Ah\n")

# Calculate average discharge voltage
average_voltage <- mean(data$voltage)
cat("Average Discharge Voltage:", average_voltage, "V\n")

# Find the time at which voltage reaches a certain threshold
threshold_voltage <- 1
threshold_time <- data$time[which.min(abs(data$Act_I - threshold_voltage))]
cat("Time at Threshold Voltage:", threshold_time, "s\n")

# Save plots and results
ggsave("discharge_plot.png")
