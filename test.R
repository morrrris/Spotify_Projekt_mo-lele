library(ggplot2)

top_tracks_2023_u <- top_tracks(u2023, 10)


ggplot(top_tracks_2023_u, aes(x= Track, y = Häufigkeit)) + geom_point(shape = 16)
