# Ctrl + Shift +  C zum Auskommentieren

# An welchen n  Tagen habe ich am längsten Musik gehört?
# data_table Datentabelle mit allen Spalten, top_n Anzahl der obersten Tage, die ausgegeben werden


top_days_time <- function(data_table, top_n){
  days_table <- data.frame(ts = substr(data_table$ts, 1, 10))
  days_table_unique <- unique(days_table)
  for(i in 1:length(days_table_unique$ts)){
    logic <- grep(days_table_unique$ts[i], days_table$ts)
    days_table_unique$sum[i] <- sum(data_table$ms_played[logic])
  }
  days_table_uni_sort <- days_table_unique[order(-days_table_unique$sum),]
  # grep(days_table_unique$ts[i], days_table$ts)
  # output <- table[(which(grepl(year, table$ts))),]
  # return(list(days_table_uni_sort$ts[1:top_n],days_table_uni_sort$sum[1:top_n] / 60000, print(sum(days_table_unique$sum)), 
  #            print(sum(data_table$ms_played))))
  return(data.frame(date = days_table_uni_sort$ts[1:top_n], Minuten = round(days_table_uni_sort$sum[1:top_n] / 60000, digits = 1)))
}
