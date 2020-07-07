#load libraries
library(tidyverse)
library(RColorBrewer)
source("http://staff.washington.edu/kpleung/vis/theme/theme_cavis.R")
library(ggExtra)

# Get nice colors
brewer <- brewer.pal(9, "Set1")
blue <- brewer[2]
orange <- brewer[5]

#load a daataset
# owid_covid_data <- read_csv("owid-covid-data.csv")
str(owid_covid_data)

#subset the dataset
covid_us <- owid_covid_data %>% filter (location == "United States") %>% filter (date >= as.Date("2019-01-21"))

covid_us <- owid_covid_data %>% filter (location == "United States") %>% filter (date >= as.Date("2019-01-21"))

#Epidemiologic Curves
ggplot(data = covid_us, aes(x = date, y = new_cases)) +
  geom_bar(stat = "identity", fill = "#0C6ABF") +
  labs(title = "Confirmed COVID-19 Case Counts in the U.S.",
       subtitle = "From January 20, 2019 to July 6, 2020",
       caption = "Data retrieved from Our World in Data",
       x = " \nDate of Illness Onset", y = "") +
  theme_light() +
  theme(plot.title = element_text(color="black", size=22, face="bold", family="Encode Sans Normal"),
        plot.subtitle = element_text(color="#969494", size=16, family="Encode Sans Narrow"),
        plot.caption = element_text(color="#969494", face="italic", size=12, family="Encode Sans Narrow"),
        axis.title.x = element_text(family="Encode Sans Narrow", size=16),
        axis.title.y = element_text(family="Encode Sans Narrow", size=16),
        axis.text = element_text(family="Encode Sans Narrow", size = 14)) +
  scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 week", date_labels = "%b %Y") +
  removeGridX() +
  scale_y_continuous(labels = scales::comma)

#Cumulative Counts
ggplot(data = covid_us, aes(x = date, y = total_cases)) +
  geom_line(color = "#0C6ABF") +
  labs(title = "Cumulative COVID-19 Case Counts in the U.S.",
       subtitle = "From January 20, 2019 to July 6, 2020",
       caption = "Data retrieved from Our World in Data",
       x = " \nDate of First Positive Lab", y = "") +
  theme_light() +
  theme(plot.title = element_text(color="black", size=22, face="bold", family="Encode Sans Normal"),
        plot.subtitle = element_text(color="#969494", size=16, family="Encode Sans Narrow"),
        plot.caption = element_text(color="#969494", face="italic", size=12, family="Encode Sans Narrow"),
        axis.title.x = element_text(family="Encode Sans Narrow", size=16),
        axis.title.y = element_text(family="Encode Sans Narrow", size=16),
        axis.text = element_text(family="Encode Sans Narrow", size = 14),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black")) +
  scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 week", date_labels = "%b %Y") +
  removeGridX() +
  scale_y_continuous(labels = scales::comma)
