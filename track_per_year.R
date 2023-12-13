# Gibt aus wie oft ein Track über die Jahre gehört wurde

track_per_year <- function(track_string,artist_name,data_table = all_data){
  df <- data_table[(which(grepl(paste0("^", track_string,"$"), data_table$master_metadata_track_name, ignore.case=TRUE))),]

  # Konvertiere 'ts' in ein Datumsobjekt
  df$ts <- ymd_hms(df$ts)
  
  # Extrahiere das Jahr aus dem Zeitstempel
  df$year <- year(df$ts)
  
  # Gruppiere nach 'master_metadata_track_name' und 'year'
  grouped_df <- group_by(df, master_metadata_track_name, year, master_metadata_album_artist_name)
  
  # Zähle die Häufigkeit
  track_frequency <- summarise(grouped_df, frequency = n())
  colnames(track_frequency) <- c("Track","Jahr","Artist","Häufigkeit")
  
  track_frequency <- track_frequency[(which(grepl(paste0(artist_name), track_frequency$Artist, ignore.case=TRUE))),]
  
  # Zeige die resultierende Tabelle an
  print(track_frequency)
  ggplot(track_frequency, aes(x = Jahr, y = Häufigkeit)) + geom_point() + geom_line() + labs(title = track_string, x = "Jahr", y = "Häufigkeit")
  
}
