# data_table Tabelle mit Rohdaten, Ausgabe in Minuten
listening_time <- function(data_table){
  output <- sum(data_table$ms_played) / 60000
  return(output)
}
