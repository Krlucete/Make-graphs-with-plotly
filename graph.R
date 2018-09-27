setwd("/Users/lucas/Desktop/R/Make-graphs-with-plotly")

#FILE input
csvData <- read.csv(file="combine.csv", header=TRUE, sep=",")
csvData <- csvData[,2:11]

totalMean <- sum(csvData$mean)

#Normalization of sum of max
#Cumulative sums of max,min,mean
csvData$cum_sum_max <- cumsum(csvData$max/totalMean)
csvData$cum_sum_min <- cumsum(csvData$min/totalMean)
csvData$cum_sum_mean <- cumsum(csvData$mean/totalMean)

library(plotly)
RGEN <- csvData$RGEN
cum_sum_max <- csvData$cum_sum_max
cum_sum_min <- csvData$cum_sum_min
cum_sum_mean <- csvData$cum_sum_mean

data <- data.frame(RGEN,cum_sum_max,cum_sum_min,cum_sum_mean)
data$RGEN <- factor(data$RGEN, levels = data[["RGEN"]])
zero_data <- data.frame(RGEN="NONE",cum_sum_max=0,cum_sum_min=0,cum_sum_mean=0)
data <- rbind(zero_data,data)

p <- plot_ly(data, x = ~RGEN, y = ~cum_sum_max, type = 'scatter', mode = 'lines',
             line = list(color = 'transparent'),    
             showlegend = TRUE, name = 'cum_sum_max') %>%
               add_trace(y = ~cum_sum_min, type = 'scatter', mode = 'lines',
                         line = list(color = 'transparent'),
                         fill = 'tonexty', fillcolor='rgba(0,100,80,0.2)',
                         showlegend = TRUE, name = 'cum_sum_min') %>%
               add_trace(x = ~RGEN, y = ~cum_sum_mean, type = 'scatter', mode = 'markers',
                         name = 'cum_sum_mean') %>%
               layout(title = "Mean, High and Low Count of RGEN",
                      paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb( m229,229,229)',
                      xaxis = list(title = "RGEN",
                                   autotick=TRUE,
                                   gridcolor = 'rgb(229,229,229)',
                                   showgrid = TRUE,
                                   showline = TRUE,
                                   showticklabels = TRUE,
                                   tickcolor = 'rgb(127,127,127)',
                                   ticks = 'outside',
                                   zeroline = TRUE),
                      yaxis = list(title = "Normalization of Count",
                                   autotick=FALSE,
                                   tick0=0,
                                   dtick=0.05,
                                   tickwidth=1,
                                   gridcolor = 'rgb(229,229,229)',
                                   showgrid = TRUE,
                                   showline = TRUE,
                                   showticklabels = TRUE,
                                   tickcolor = 'rgb(127,127,127)',
                                   ticks = 'outside',
                                   zeroline = TRUE))
p

write.csv(csvData, file="graph.csv",row.names=TRUE)
 
