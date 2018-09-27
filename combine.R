setwd("/Users/lucas/Desktop/R/Make-graphs-with-plotly")

input_file <- read.table(file="input1.txt", sep="\t", header=F, stringsAsFactors=F, na.strings="NA")
RGEN       <- input_file[,3]
Count      <- input_file[,5]
Type       <- input_file[,6]
input1     <- cbind(RGEN, Count, Type)
input1     <- subset(input1, Type!="WT or Sub")
input1

input_file <- read.table(file="input2.txt", sep="\t", header=F, stringsAsFactors=F, na.strings="NA")
RGEN       <- input_file[,3]
Count      <- input_file[,5]
Type       <- input_file[,6]
input2     <- cbind(RGEN, Count, Type)
input2     <- subset(input2, Type!="WT or Sub")


input_file <- read.table(file="input3.txt", sep="\t", header=F, stringsAsFactors=F, na.strings="NA")
RGEN       <- input_file[,3]
Count      <- input_file[,5]
Type       <- input_file[,6]
input3     <- cbind(RGEN, Count, Type)
input3     <- subset(input3, Type!="WT or Sub")

collection_of_input <- merge(input1, input2, by=c('RGEN'), all=TRUE)
collection_of_input <- merge(collection_of_input, input3, by=c('RGEN'), all=TRUE)

input1_count <- as.numeric(as.character(collection_of_input[,2]))
input2_count <- as.numeric(as.character(collection_of_input[,3]))
input3_count <- as.numeric(as.character(collection_of_input[,4]))
collection_of_count <- cbind(input1_count,input2_count,input3_count)

rm(input1_count)
rm(input2_count)
rm(input3_count)

mean <- apply(collection_of_count,1,sum,na.rm=TRUE)/3
min  <- apply(collection_of_count,1,min,na.rm=TRUE)
max  <- apply(collection_of_count,1,max,na.rm=TRUE)

rm(collection_of_count)

results <- cbind(collection_of_input, mean, min, max)
results <- results[ order(-mean, -max, -min), ]
write.csv(results, file="combine.csv",row.names=TRUE)

