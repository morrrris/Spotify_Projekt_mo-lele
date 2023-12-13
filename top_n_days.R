
top_n_days <- function(data_table,n){
  top <- table(substr(data_table$ts, start = 1, stop = 10))
  sortiert <- sort(top, decreasing = TRUE)
  output <- head(sortiert, n)
  
  return(output)
}


top_n_days_ms <- function(data_table){
 
  
  data_table$ts <- as.Date(data_table$ts)
  max_date <- select(filter(arrange(data_table, desc(data_table$ms_played)), row_number(desc(data_table$ms_played)) == 1), ts)
  
  return(list(max_date,max(data_table$ms_played)/60000))
}

