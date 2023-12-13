library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyverse)
library(tidyr)
library(viridis)
library(MASS)
library(hrbrthemes)
library(GGally)
library(svglite)
# Verzeichnis mit JSON-Dateien angeben
json_files_directory <- "C:/Users/morit/Documents/RStudio/Spotify/Spotify/dave/Spotify Extended Streaming History"

# Liste für geladene Daten erstellen
loaded_data_list <- list()

# Schleife durch alle JSON-Dateien im Verzeichnis
json_file_list <- list.files(path = json_files_directory, pattern = "\\.json$", full.names = TRUE)
for (json_file in json_file_list) {
  loaded_data <- fromJSON(json_file)
  loaded_data_list[[json_file]] <- loaded_data
}

all_dave = bind_rows(loaded_data_list)


hours_played = sum(all_data$ms_played)/3600000

# Tabellen mit allen Einträgen
y2014 <- extract_year("2014",all_data)
y2015 <- extract_year("2015",all_data)
y2016 <- extract_year("2016",all_data)
y2017 <- extract_year("2017",all_data)
y2018 <- extract_year("2018",all_data)
y2019 <- extract_year("2019",all_data)
y2020 <- extract_year("2020",all_data)
y2021 <- extract_year("2021",all_data)
y2022 <- extract_year("2022",all_data)
y2023 <- extract_year("2023",all_data)


# Alle Einträge die länger als 30 Sekunden gespielt wurden
x2014 <- extract_year("2014",all)
x2015 <- extract_year("2015",all)
x2016 <- extract_year("2016",all)
x2017 <- extract_year("2017",all)
x2018 <- extract_year("2018",all)
x2019 <- extract_year("2019",all)
x2020 <- extract_year("2020",all)
x2021 <- extract_year("2021",all)
x2022 <- extract_year("2022",all)
x2023 <- extract_year("2023",all)


# Alle ungeskippten Einträge
u2014 <- extract_year("2014",all_unskipped)
u2015 <- extract_year("2015",all_unskipped)
u2016 <- extract_year("2016",all_unskipped)
u2017 <- extract_year("2017",all_unskipped)
u2018 <- extract_year("2018",all_unskipped)
u2019 <- extract_year("2019",all_unskipped)
u2020 <- extract_year("2020",all_unskipped)
u2021 <- extract_year("2021",all_unskipped)
u2022 <- extract_year("2022",all_unskipped)
u2023 <- extract_year("2023",all_unskipped)
