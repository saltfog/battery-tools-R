

# Load required packages
library(dplyr)
library(ggplot2)
library(data.table)

# Read the battery data from CSV file
library(readxl)
data <- read_excel("~/Downloads/SP3_Initial capacity_10_16_2015/sp20.xlsx")

str(data)

# Basic data summary
summary(data)

# Plot voltage vs. time
ggplot(data, aes(x = data$`Test_Time(s)`, y = data$`Voltage(V)`)) +
  geom_line() +
  labs(title = "Battery Discharge",
       x = "Time (s)", y = "Voltage (V)") + theme_light()

# Calculate discharge capacity
discharge_capacity <- sum(data$`Voltage(V)`) * (data$`Test_Time(s)`[2] - data$`Test_Time(s)`[1])
cat("Discharge Capacity:", discharge_capacity, "Ah\n")

discharge_capacity / 3600

# Calculate average discharge voltage
average_voltage <- mean(data$`Voltage(V)`)
cat("Average Discharge Voltage:", average_voltage, "V\n")

# Find the time at which voltage reaches a certain threshold
threshold_voltage <- 3.8
threshold_time <- data$`Test_Time(s)`[which.min(abs(data$`Voltage(V)` - threshold_voltage))]
cat("Time at Threshold Voltage:", threshold_time, "s\n")

# Save plots and results
ggsave("discharge_plot.png")


# Plot voltage vs. time
ggplot(data, aes(x = data$`Test_Time(s)`, y = data$`Discharge_Capacity(Ah)`)) +
  geom_line() +
  labs(title = "Capacity Discharge",
       x = "Time (s)", y = "Voltage (V)") + theme_light()
