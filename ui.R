
#http://shiny.rstudio.com/gallery/word-cloud.html


shinyUI(fluidPage(
    # Application title
    titlePanel("#Vegan Tweet Exploration"),
    
    sidebarLayout(
        sidebarPanel(
            h6("Top 6 terms in #vegan tweets"),
            radioButtons("term", "Select Term for Word Cloud:", 
                         topTerms)),
        # tabs
        mainPanel(
            
            tabsetPanel(type="tabs",
                        #tabPanel("Plot",plotOutput("plot")),
                        #tabPanel("Map",plotOutput("map")),
                        tabPanel("Word Cloud",plotOutput("wordcloud")),
                        tabPanel("All #vegan Cloud", plotOutput("largecloud")),
                        tabPanel("All #vegan Summary", verbatimTextOutput("summary"))
            ),
            h3("The Background:"),
            p("This was a project for the Creating Data Projects course in the ",
              "Data Science Specialization at ",a("Coursera.org")),
            h4("The Tweets:"),
            p("This was a pull from ",
              a("http://twitter.com/"), "using a #vegan as a search.",
              " All were downloaded in a seperate script and written to a \"tweets.csv\" file"),
            h4("The Cloud:"),
            p("The interactive panel only works with the Word Cloud"),
            p("The subsequent word cloud only shows those terms related to the selected terms"),
            h5("Some places I went for inspiration (but not all inclusive):"),
            a("http://shiny.rstudio.com/articles/tabsets.html"),
            a("http://onertipaday.blogspot.com/2011/07/word-cloud-in-r.html"),
            a("http://www.rdatamining.com/examples/text-mining"),
            a("http://stackoverflow.com/questions/15506118/make-dataframe-of-top-n-frequent-terms-for-multiple-corpora-using-tm-package-in"),
            a("http://davetang.org/muse/2013/04/06/using-the-r_twitter-package/")
        )
    )
))
