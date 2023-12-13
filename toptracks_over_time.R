library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyverse)
library(tidyr)
library(viridis)
library(hrbrthemes)
library(svglite)
library(plotly)
library(htmlwidgets)


toptracks_over_time <- function(data = all_data){
  
  data$ts <- ymd_hms(data$ts)
  
  # Extrahiere das Jahr und Monat aus dem Zeitstempel
  data$year <- year(data$ts)

  
  
  
  data <- data %>%
    select(year, master_metadata_track_name, master_metadata_album_artist_name)
    #colnames(data) <- c("year","Track","Artist")
  
  result <- split(data,data$year)
  top <- list()
  
  for (i in min(unique(data$year)):max(unique(data$year))){ #min(unique(data$year)):max(unique(data$year))
    a <- result[[as.character(i)]]
    if (!is.null(a)){
    b <- top_tracks(a,100)
    
    b$Platz <- seq(1, nrow(b))
    top[[as.character(i)]] <- b
    }
  }
    
  combined_df <- bind_rows(top, .id = "Jahr")
  
  # Häufigkeit für farbliche markierung
  häufigkeiten <- table(combined_df$Track)
  combined_df$haufung <- häufigkeiten[match(combined_df$Track, names(häufigkeiten))]
  
  
  # Plot
  p <- ggplot(combined_df, aes(x = Jahr,y = Platz,group = Track, color = Track)) +
    geom_line(aes(x = factor(Jahr), y = Platz)) +
    geom_point(shape = 16, size = 1) + 
    #geom_text(aes(label = Track), vjust = -0.5, hjust = 0.5, size = 3) +  
    labs(title = "Top 100 2014-2023", x = "Jahr", y = "Platzierung") +
    theme_ipsum() +
    theme(legend.position="none") +
    scale_y_reverse(breaks = seq(0,100 , by = 10))
    
    
  # print(p)
  # svglite("my_plot.svg", width = 6, height = 4)
  # print(p)
  # dev.off()
  
  #ggsave("Top100.pdf", plot = p, device = "pdf", wPlatzth = 30, height = 30, units = "in", dpi = 300)
  plotly_plot <- ggplotly(p)
  # dev.off()
  # return(combined_df)
  saveWidget(plotly_plot, file = "interactive_Top100_Dave.html")
}
