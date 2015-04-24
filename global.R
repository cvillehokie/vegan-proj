library(tm)
library(wordcloud)
library(memoise)
library(maps)
library(mapproj)

#trying to get out the obvious terms we don't want (twitter was searched for #vegan)
custom_stopwords <- c("vegan", "http", "amp", stopwords('english'))

removeURL <- function(x) gsub("http","", x) #simple function to remove http stubs

my_tweets<-as.data.frame(read.csv("tweets.csv"))#bring in data

#develop corpus
myCorpus <- Corpus(VectorSource(my_tweets$text))
myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus <- tm_map(myCorpus, tolower)
myCorpus <- tm_map(myCorpus, removeURL)
myCorpus <- tm_map(myCorpus, removeWords, custom_stopwords)

myCorpus <- Corpus(VectorSource(myCorpus))

myDTM = TermDocumentMatrix(myCorpus,
                           control = list(minWordLength = 2))

#find the top 5 used terms
myMatrix <- as.matrix(myDTM)
myMatrix <- sort(rowSums(myMatrix), decreasing=TRUE)
topTerms <- names(head(myMatrix))

myMatrix <- as.data.frame(myMatrix)
myMatrix$names <- rownames(myMatrix)
colnames(myMatrix) <- c("freq","names")
myMatrix <- myMatrix[!grepl("http",myMatrix$names),] #gets out URLs

#smaller subset w/ freq set at 30 - wordcloud will take a while to run as it is
myMatrix_30<-myMatrix[myMatrix$freq > 30,] 

#data cleanup
rm("custom_stopwords","myCorpus")