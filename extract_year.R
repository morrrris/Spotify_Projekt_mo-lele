# year als "string", table eine Tabelle mit Rohdaten

extract_year <- function(year, table){
  output <- table[(which(grepl(year, table$ts))),]
  return(output)
}

# testtable <- extract_year("2020", all_data)
