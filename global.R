#borrowed a bit from here
#http://davetang.org/muse/2013/04/06/using-the-r_twitter-package/

#and of course: http://shiny.rstudio.com/gallery/

library(tm)
library(wordcloud)
library(memoise)

#don't see why our search term from twitter should be in the cloud
custom_stopwords <- c(searchterm, "vegan", stopwords('english'))

all_tweets<-as.data.frame(read.csv("tweets.csv"))#bring in data

#turn created field into a date field
all_tweets$created <- as.Date(all_tweets$created)

getTermMatrix <- memoise(function(makecloud) { #might need to name the function

    my_tweets <- all_tweets[all_tweets$created>=lowest & all_tweets$created<=highest,]
    
    myCorpus <- Corpus(VectorSource(my_tweets$text))
    myCorpus <- tm_map(myCorpus, removePunctuation)
    myCorpus <- tm_map(myCorpus, tolower)
    myCorpus <- tm_map(myCorpus, removeWords, custom_stopwords)
    
    
    myDTM = TermDocumentMatrix(myCorpus,
                               control = list(minWordLength = 1))
    
    m = as.matrix(myDTM)
    
    sort(rowSums(m), decreasing = TRUE)
    }
)
