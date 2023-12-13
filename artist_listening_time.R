# data_table Tabelle mit Rohdaten, artist_string als "string". Groß- und Kleinschreibung egal, Ausgabe in Minuten

artist_listening_time <- function(artist_string, data_table){
  aux_table <- data_table[(which(grepl(artist_string, data_table$master_metadata_album_artist_name, ignore.case=TRUE))),]
  output <- sum(aux_table$ms_played) / 60000
  return(output)
}
