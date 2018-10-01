setwd("/Users/lucas/Desktop/R/Make-graphs-with-plotly")

#FILE input
csvData <- read.csv(file="combine.csv", header=TRUE, sep=",")
csvData <- csvData[,2:12]

totalMean <- sum(csvData$mean)

#Normalization of sum of max
csvData$cum_sum_mean <- cumsum(csvData$mean/totalMean)

library(plotly)
RGEN <- csvData$RGEN
cum_sum_mean <- csvData$cum_sum_mean
stdev <- (csvData$stdev)/totalMean

data <- data.frame(RGEN,cum_sum_mean,stdev)
data$RGEN <- factor(data$RGEN, levels = data[["RGEN"]])
zero_data <- data.frame(RGEN="NONE",cum_sum_mean=0,stdev=0)
data <- rbind(zero_data,data)

p <- plot_ly(data, 
             x = ~RGEN, 
             y = ~cum_sum_mean, 
             type = 'scatter',
             error_y = list(type = "data", array = ~stdev, color='rgba(243,129,129,1)'), 
             line = list(color = 'transparent'),
             showlegend = TRUE, name = 'cum_sum_max') %>%
               layout(title = "Mean, High and Low Count of RGEN",
                      paper_bgcolor='rgb(255,255,255)',
                      plot_bgcolor='rgb( m229,229,229)',
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



