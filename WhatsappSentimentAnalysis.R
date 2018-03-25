library(readtext)
TextData <- readtext("_chatAnish.txt") 

TextData <- as.data.frame(TextData) 
library(slam)
library(tm)
CleanData <- tolower(TextData$text)#Turn the data into lower case
mystopwords <- c("medha pandey", "ashi","pm","am","????Zimage","omitted" ,"â???"","<", ">","????zattached", stopwords("en")) #Define all the words which are not required 
CleanData <- removeWords(CleanData, mystopwords)
CleanData <- removePunctuation(CleanData)
CleanData <- removeNumbers(CleanData) 
CleanData <- stemmer(CleanData, rm.bracket = TRUE)
library(wordcloud) 
library(qdap)



TextFrequency <- freq_terms(CleanData, at.least = 1) 


wordcloud(TextFrequency$WORD, TextFrequency$FREQ, colors = TextFrequency$FREQ, max.words = 200)
library(syuzhet)



Sentiments <- get_nrc_sentiment(TextFrequency$WORD)
Sentiments <- cbind("Words" = TextFrequency$WORD, Sentiments)
SentimentsScore <- data.frame("Score" = colSums(Sentiments[2:11])) 
TotalSentiments <- cbind("Sentiments" = rownames(SentimentsScore), SentimentsScore)
rownames(TotalSentiments) <- NULL 
library(ggplot2)
ggplot(data = TotalSentiments, aes(x = Sentiments, y = Score)) + geom_bar(stat = "identity", aes(fill = Sentiments))

