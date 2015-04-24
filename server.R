#http://shiny.rstudio.com/gallery/word-cloud.html

shinyServer(function(input, output) {
    
    find_assocs <- reactive ({
        withProgress({setProgress(message = "Processing...")})
        findAssocs(myDTM, input$term, 0.18)
    })
    
    wordcloud_rep<-repeatable(wordcloud)
    
    #reactive word cloud for user-selected terms within #vegan tweets
    output$wordcloud <- renderPlot({  
        v <- find_assocs()
        
        wordcloud_rep(names(v[,1]), v, scale=c(3,0.2),
                      min.freq = 3,
                      random.order=FALSE,
                      random.color=TRUE,
                      rot.per=.15,
                      max.words=50,
                      colors=brewer.pal(8, "Dark2"))
        
    })
    
    output$summary <- renderPrint({ #user to see summary data of all tweets
        summary(my_tweets)
    })
    
    output$largecloud <- renderPlot({ #big cloud of all #vegan tweets
        wordcloud(myMatrix_30$names, myMatrix_30$freq, scale=c(3,0.5),
                  random.order=FALSE,
                  random.color=TRUE,
                  max.words=50,
                  rot.per=.15,
                  colors=brewer.pal(8, "Dark2"))
    })
}
)

