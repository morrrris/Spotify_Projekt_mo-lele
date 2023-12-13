

insert_na_rows <- function(df, na_rows = 4) {
  rows_to_insert <- which(diff(df$Jahr) > 0)
  rows_to_insert[2:length(rows_to_insert)] <-  rows_to_insert[2:length(rows_to_insert)] + (1:length(rows_to_insert)) * na_rows
  

  
  for (row in rows_to_insert) {
    na_data <- data.frame(lapply(df, function(x) rep(NA, na_rows)))
    df <- rbind(df[seq_len(row), ], na_data, df[(row + 1):nrow(df), ])



    # rows_to_insert <- rows_to_insert + na_rows  # Update rows_to_insert
  }

  # df <- rbind(df, data.frame(lapply(df, function(x) rep(NA, length(x)))))

  return(df)
}







