#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

dataset <- diamonds

fluidPage(
    
    titlePanel("Diamonds Explorer"),
    
    sidebarPanel(
        
        sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                    value=min(2000, nrow(dataset)), step=500, round=0),
        
        selectInput('x', 'X', names(dataset), selected = names(dataset)[1]),
        selectInput('y', 'Y', names(dataset), selected = names(dataset)[7]),
        selectInput('color', 'Color', c('None', names(dataset)), selected = names(dataset)[3]),
        
        checkboxInput('smooth', 'Smooth'),
        
        selectInput('facet_row', 'Facet Row', c(None='.', names(dataset)), selected = names(dataset)[2]),
        selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)), selected = names(dataset)[4])
    ),
    
    mainPanel(
        plotOutput('plot')
    )
)
