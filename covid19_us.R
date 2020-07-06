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

#plot a time series figure
ggplot(data = covid_us, aes(x = date, y = new_cases)) +
  geom_bar(stat = "identity", fill = "#0C6ABF") +
  labs(title = "Confirmed COVID-19 cases in the U.S.",
       subtitle = "From January 20, 2019 to July 6, 2020",
       caption = "Data retrieved from Our World in Data",
       x = "Date of Illness Onset", y = "Confirmed cases") +
  theme_bw() +
  theme(plot.title = element_text(color="black", size=22, face="bold", family="Helvetica"),
        plot.subtitle = element_text(color="#969494", size=16, family="Helvetica"),
        plot.caption = element_text(color="#969494", face="italic", size=12, family="Helvetica"),
        axis.title.x = element_text(family="Helvetica", size=14),
        axis.title.y = element_text(family="Helvetica", size=14)) +
  scale_x_date(date_labels = "%b-%y") +
  removeGridX()