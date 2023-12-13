# Wie oft habe ich dieses Lied gehört?
# data_table Tabelle mit Rohdaten, track_string als "string". Groß- und Kleinschreibung egal, Ausgabe in Minuten

track_listening_counter <- function(track_string, data_table = all_data){
  aux_table <- data_table[(which(grepl(paste0("^", track_string, "$"), data_table$master_metadata_track_name, ignore.case=TRUE))),]
  # aux_table$ts <- ymd_hms(aux_table$ts)
  output <- nrow(aux_table)
  
  
  output[2] <- head(sort(aux_table$ts, decreasing = FALSE),1)
  # output <- as.data.frame(output)
  #colnames(output)<- c("Anzahl","Erstes mal gehört")
  return(output)
}

