
#http://shiny.rstudio.com/gallery/word-cloud.html


shinyUI(fluidPage(
    # Application title
    titlePanel("Word Cloud"),
    
    sidebarLayout(        
        # Sidebar with a slider and selection inputs
        sidebarPanel(
            dateRangeInput('dateRange',
                           label = 'Date range input: yyyy-mm-dd',
                           start = Sys.Date() - 2, end = Sys.Date() + 2
            ),
            actionButton("update", "Change"),
            hr()
           
        ),
        
        # Show Word Cloud
        mainPanel(
            plotOutput("plot")
        )
    )
))
