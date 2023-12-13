

artist_accordance <- function(data = all_data){
  
  data$ts <- ymd_hms(data$ts)
  
  # Extrahiere das Jahr und Monat aus dem Zeitstempel
  data$year <- year(data$ts)
  
  data <- data %>%
    select(year, master_metadata_track_name, master_metadata_album_artist_name) %>%
    rename(year = year,
           track = master_metadata_track_name,
           artist = master_metadata_album_artist_name)
  
  years <- split(data,data$year)
  # return(years)
  percentages <- list()
  
  for (i in (min(unique(data$year))):(max(unique(data$year))-1)){
    a <- unique(years[[as.character(i)]]$artist)
    b <- unique(years[[as.character(i+1)]]$artist)
    common <- intersect(a,b)
    percentage <- length(common) / length(unique(c(a,b))) * 100
    
    percentages[[i+1-min(unique(data$year))]] <- percentage
  }
  
  return(percentages)
  
}
