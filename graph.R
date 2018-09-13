setwd("/Users/lucas/Desktop/R")
Sys.setenv("plotly_username" = "LEEDOHYEON")
Sys.setenv("plotly_api_key" = "tRssVfJLT6LEb8AGXLzR")

#FILE input
csvData <- read.csv(file="combine.csv", header=TRUE, sep=",")
csvData <- csvData[,2:8]

totalMax <- sum(csvData$max)

#Normalization of sum of max
#Cumulative sums of max,min,mean
csvData$cum_sum_max <- cumsum(csvData$max/totalMax)
csvData$cum_sum_min <- cumsum(csvData$min/totalMax)
csvData$cum_sum_mean <- cumsum(csvData$mean/totalMax)

library(plotly)
RGEN <- csvData$RGEN
cum_sum_max <- csvData$cum_sum_max
cum_sum_min <- csvData$cum_sum_min
cum_sum_mean <- csvData$cum_sum_mean

data <- data.frame(RGEN,cum_sum_max,cum_sum_min,cum_sum_mean)
data$RGEN <- factor(data$RGEN,levels = data[["RGEN"]])

p <- plot_ly(data, x = ~RGEN, y = ~cum_sum_max, type = 'scatter', mode = 'markers',
                          showlegend = FALSE, name = 'cum_sum_max') %>%
               add_trace(y = ~cum_sum_min, type = 'scatter', mode = 'markers',
                         fill = 'tonexty', fillcolor='rgba(0,100,80,0.2)',
                         showlegend = FALSE, name = 'cum_sum_min') %>%
               add_trace(x = ~RGEN, y = ~cum_sum_mean, type = 'scatter', mode = 'markers',
                         name = 'cum_sum_mean') %>%
               layout(title = "Mean, High and Low Count of RGEN",
                      paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
                      xaxis = list(title = "RGEN",
                                   gridcolor = 'rgb(255,255,255)',
                                   showgrid = TRUE,
                                   showline = FALSE,
                                   showticklabels = TRUE,
                                   tickcolor = 'rgb(127,127,127)',
                                   ticks = 'outside',
                                   zeroline = FALSE),
                      yaxis = list(title = "Normalization of Count",
                                   autotick=FALSE,
                                   tick0 = 0,
                                   dtick=0.1,
                                   gridcolor = 'rgb(255,255,255)',
                                   showgrid = TRUE,
                                   showline = FALSE,
                                   showticklabels = TRUE,
                                   tickcolor = 'rgb(127,127,127)',
                                   ticks = 'outside',
                                   zeroline = FALSE))
p

write.csv(csvData, file="graph.csv",row.names=TRUE)

