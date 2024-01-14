library(dplyr)
library(ggplot2)
library(rstan) 

penguins <- readRDS("penguins.RDS")

# Viewing the first few rows of the dataset
head(penguins)

# Summary of the dataset
summary(penguins)

# Histogram of bill lengths for each species
ggplot(penguins, aes(x = bill_length, fill = species)) +
  geom_histogram(bins = 30, alpha = 0.6) +
  facet_wrap(~species) +
  theme_minimal() +
  labs(title = "Bill Length Distribution by Species", x = "Bill Length (mm)", y = "Count")

# Boxplot for bill length by species and sex
ggplot(penguins, aes(x = species, y = bill_length, fill = sex)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Bill Length by Species and Sex", x = "Species", y = "Bill Length (mm)")

# Scatter plot of bill length vs bill depth for each species
ggplot(penguins, aes(x = bill_depth, y = bill_length, color = species)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Bill Length vs Bill Depth", x = "Bill Depth (mm)", y = "Bill Length (mm)")

# Scatter plot of bill length vs bill depth for each species
ggplot(penguins, aes(x = bill_depth, y = bill_length, color = species)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Bill Length vs Bill Depth", x = "Bill Depth (mm)", y = "Bill Length (mm)")

#This should be easily separable

# Scatter plot of bill length vs bill depth for each species
ggplot(penguins, aes(x = bill_depth, y = bill_length, color = sex)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Bill Length vs Bill Depth", x = "Bill Depth (mm)", y = "Bill Length (mm)")

#not in general but in each species


###
