#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(Quandl)
library(scales)
library(ggplot2)
library(quantmod)
library(tidyquant)
library("TTR")

Quandl.api_key("e-AuZ1T6HYBqxxbvGB7M")

# Define UI for application that draws a histogram
ui <- fluidRow(
    
    # Application title
    titlePanel("Stocks affected by COVID-19"),
    mainPanel(
        p("Stock prices for individual stocks, oil exchange traded funds, and index funds dropped in response to COVID-19 in March 2020. The market has since then recovered due to Federal Reserve Bailouts.")
    ),
    
    #date
    fluidRow(
        column(3,
               selectInput("symbols",
                           h3("Ticker Symbol"),
                          choices = c("TESLA"="TSLA","APPLE"="AAPL")),
               
        ),
        
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Results")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$Results <- renderPlot({
        
        currency= tq_get(input$symbols,
                         from = "2020-01-01",
                         to = "2020-06-01",
                         get = "stock.prices")
        
        #currencydf=data.frame(currency)
        #simplemovingaverage=SMA(currencydf$currency, n=15)
        plot(ggplot(currency,aes(x = date, y = adjusted, color = symbol)) +
            geom_line()+
            labs(x="Date",y="Adjusted Price in Dollars")+
                geom_text(aes(x = as.Date("2020-03-10"), y = -5, label = "Coronavirus Outbreak"))+
                theme(legend.position = "none"))
        #plot(currency$close,  type="l",col="blue",xlab="Date", ylab="Rate in Dollars")
        #lines(simplemovingaverage,type='l', col='red'), 
        title(main = input$symbols)
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

