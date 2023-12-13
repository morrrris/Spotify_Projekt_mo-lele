# Welches Lied hast du an einem Tag am häufigsten gehört, welcher Tag und wie oft?
# Input: data_table - Datentabelle
#        top_n      - Anzahl der ausgegeben Tage

track_per_year_1 <- function(data_table = all_data, top_n){
  data_table <- subset(data_table, ms_played > 30000) # Streams mit weniger als 30s Dauer rausfiltern, für Spotify zählt ein stream ebenfalls nach 30s
  # aux_table <- data_table[(which(grepl(paste0("^", track_string, "$"), data_table$master_metadata_track_name, ignore.case=TRUE))),]
  days_table <- data.frame(ts = substr(data_table$ts, 1, 10))
  days_table_unique <- unique(days_table)
  top_tracks_all_days <- data.frame(date = days_table_unique)
  for(i in 1:length(days_table_unique$ts)){
    logic <- grep(days_table_unique$ts[i], days_table$ts)
    # days_table_unique$sum[i] <- sum(data_table$ms_played[logic])
    one_day_table <- data.frame(track = data_table$master_metadata_track_name[logic])
    häufigkeiten_track_day <- sort(table(one_day_table$track), decreasing = TRUE)
    # sortierte_häufigkeiten <- sort(häufigkeiten_track, decreasing = TRUE)
    hottest_track <- head(häufigkeiten_track_day, 1)
    top_tracks_all_days$track[i] = attr(hottest_track, "names");
    top_tracks_all_days$plays[i] = hottest_track
  }
  top_tracks_all_days <- top_tracks_all_days[order(-top_tracks_all_days$plays), ]
  return(head(top_tracks_all_days, top_n))
}
