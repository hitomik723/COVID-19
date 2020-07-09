##### load libraries
library(tidyverse)
library(RColorBrewer)
source("http://staff.washington.edu/kpleung/vis/theme/theme_cavis.R")
library(ggExtra)
library(extrafont)
library(ggthemes)
# font_import() #import extra fonts
fonttable() # this will show a table of available fonts

##### Get nice colors
brewer <- brewer.pal(8, "Set2")
green <- brewer[1]
orange <- brewer[2]
blue <- brewer[3]
pink <- brewer[4]
grass <- brewer[5]
yellow <- brewer[6]
brown <- brewer[7]
gray <- brewer[8]

##### load a daataset
owid_covid_data <- read_csv("owid-covid-data.csv")
str(owid_covid_data)

##### subset the dataset
covid_us <- owid_covid_data %>% filter (location == "United States") %>% filter (date >= as.Date("2019-01-21"))

##### Cerate plots
### Plot1. Epidemiologic Curves
ggplot(data = covid_us, aes(x = date, y = new_cases)) +
  geom_bar(stat = "identity", fill = "#0C6ABF") +
  labs(title = "Confirmed COVID-19 Case Counts in the U.S.",
       subtitle = "From January 20, 2020 to July 6, 2020",
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
  scale_y_continuous(labels = scales::comma, expand = c(0, 0))


### Plot2. Cumulative Counts in the world
#subset the dataset
covid_world <- owid_covid_data %>% filter (location == "United States" | location == "Mexico" | location == "Canada" | location == "China" | location == "Japan" | location == "Italy" | location == "United Kingdom"| location == "Brazil")
#str(covid_world)

ggplot(data = covid_world, aes(x = date, y = total_cases)) +
  geom_line(aes(color = location), size = 1.2) +
  scale_color_manual(values = c(gray, orange, blue, pink, grass, yellow, brown, green)) +
  labs(title = "Cumulative COVID-19 Case Counts in the World",
       subtitle = "From December 31, 2019 to July 6, 2020",
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
        axis.line = element_line(colour = "black"),
        legend.title = element_blank()) +
  scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 week", date_labels = "%b %Y") +
  removeGridX() +
  scale_y_continuous(labels = scales::comma)

### Plot3. Cumulative Counts by continent
#subset the dataset
covid_continent <- owid_covid_data %>% filter (!is.na(continent))

ggplot(data = covid_continent, aes(x = date, y = total_cases, group = location, color = continent)) +
  geom_line() +
  facet_wrap(~ continent) +
  scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 week", date_labels = "%b %Y") +
  labs(title = "Cumulative COVID-19 Case Counts by Continent",
       subtitle = "From December 31, 2019 to July 6, 2020",
       caption = "Data retrieved from Our World in Data",
       x = " \nDate of First Positive Lab", y = "") +
  scale_colour_wsj() +
  theme_wsj() +
  theme(plot.title = element_text(size = 20),
        plot.subtitle = element_text(size = 16),
        plot.caption = element_text(size = 12),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        legend.position = "none",
        strip.text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::comma)

### Plot4. Cumulative Counts in the U.S.
ggplot(data = covid_us, aes(x = date, y = total_cases)) +
  geom_line(color = "#0C6ABF") +
  labs(title = "Cumulative COVID-19 Case Counts in the U.S.",
       subtitle = "From January 20, 2020 to July 6, 2020",
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
  scale_y_continuous(labels = scales::comma) +
  scale_colour_wsj() +
  theme_wsj()
