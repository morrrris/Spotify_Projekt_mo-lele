

# Aufzeigen der Hörlänge im Monat
# Jahre werden nacheinander Animiert

library(ggplot2)
library(gganimate)
library(lubridate)
library(tidyverse)
library(tidyr)
library(jsonlite)
library(dplyr)

artist_per_month_anim <- function(artist_name, data = all_data){
  df <- data[(which(grepl(artist_name, data$master_metadata_album_artist_name, ignore.case=TRUE))),]
  # Konvertiere 'ts' in ein Datumsobjekt
  df$ts <- ymd_hms(df$ts)
  
  # Extrahiere das Jahr und Monat aus dem Zeitstempel
  df$year <- year(df$ts)
  df$month <- month(df$ts)
  
  
  # Erstellen der Zieltabelle
  ergebnisse <- summarise(group_by(df, year,month), summe_spalte2 = sum(ms_played / 60000))
  colnames(ergebnisse) <- c("Jahr", "Monat","Zeit")
  #return(ergebnisse)
  
  #Plot
  
  # 1. Leerer Bereich
  
  
  # Fügt Abstände zwischen den Jahren ein
  
  # if (length(unique(na.omit(ergebnisse$Jahr))) != 1){
  #   
  #   empty_bar <- 1
  #   
  #   # Add lines to the initial dataset
  #   to_add <- data.frame(matrix(NA, empty_bar, ncol(ergebnisse)))
  #   colnames(to_add) <- colnames(ergebnisse)
  #   ergebnisse <- rbind(ergebnisse, to_add)
  #   ergebnisse <- insert_na_rows(ergebnisse,empty_bar)
  # }
  
  
  
  ergebnisse$id <- seq(1, nrow(ergebnisse))
  # return(ergebnisse)
  
  
  
  # 2. Base Lines
  # base_data <- ergebnisse %>%
  #   group_by(Jahr) %>%
  #   summarize(start=min(id), end=max(id)) %>%
  #   rowwise() %>%
  #   mutate(title=mean(c(start, end)))
  # 
  # base_data <- head(base_data, n = nrow(base_data) - 1)
  
  # prepare a data frame for grid (scales)
  # grid_data <- base_data
  # grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  # grid_data$start <- grid_data$start - 1
  # grid_data <- grid_data[-1,]
  # 
  
  # 3. Label
  
  label_data <- ergebnisse
  
  # calculate the ANGLE of the labels
  number_of_bar <- nrow(label_data)
  angle <-  90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust<-ifelse( angle < -90, 1, 0)
  label_data$angle<-ifelse(angle < -90, angle+180, angle)
  
  
  
  # 4. Farben
  # color_palette <- viridis_pal()(length(unique(ergebnisse$Jahr)))
  
  p <- ggplot(ergebnisse, aes(x=as.factor(id), y=Zeit, fill = Monat)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id), y=Zeit, fill=Jahr), stat="identity", alpha=0.5) +
    
    # Add a val=100/75/50/25 lines. I do it at the beginning to make sur barplots are OVER it.
    # geom_segment(data=grid_data, aes(x = end, y = 500, xend = start, yend = 500), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
    # geom_segment(data=grid_data, aes(x = end, y = 250, xend = start, yend = 250), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
    # geom_segment(data=grid_data, aes(x = end, y = 100, xend = start, yend = 100), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
    # geom_segment(data=grid_data, aes(x = end, y = 50, xend = start, yend = 50), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
    # geom_segment(data=grid_data, aes(x = end, y = 25, xend = start, yend = 25), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 100/75/50/25 lines
    #annotate("text", x = rep(max(ergebnisse$id),4), y = c(25, 50, 100, 250), label = c("25", "50", "100", "250") , color="grey", size=3 , angle=0, fontface="bold", hjust=1) +
    
    
    
    # This add the bars with a blue color
    geom_bar(aes(x=as.factor(id), y=Zeit, fill=Jahr),stat="identity", alpha = 0.5) +
    
    # ?????
    # scale_fill_manual(Zeit = color_palette) +
    
    # Limits of the plot = very important. The negative value controls the size of the inner circle, the positive one is useful to add size over each bar
    ylim(-100,max(na.omit(ergebnisse$Zeit))) +
    #scale_y_log10() +
    
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-2,4), "cm")     # This remove unnecessary margin around plot
    ) +
    
    # This makes the coordinate polar instead of cartesian.
    coord_polar(start = 0) +
    transition_time(Jahr) +
    ease_aes('linear')
    
    # geom_text(data=label_data, aes(x=id, y=Zeit+10, label= month.abb[Monat], hjust=hjust), color="black", fontface="bold",alpha=0.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # geom_segment(data=base_data, aes(x = start, y = -5, xend = end, yend = -5), colour = "black", alpha=0.8, linewidth=0.6 , inherit.aes = FALSE )  +
    # geom_text(data=base_data, aes(x = title, y = -18, label=Jahr), colour = "black", alpha=0.8, size=4, fontface="bold", inherit.aes = FALSE) +
    # ggtitle(artist_name)
  
  anim_save("Monate.gif")
  
  }


