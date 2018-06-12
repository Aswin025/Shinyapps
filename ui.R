#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

shinyUI(fluidPage(
  titlePanel("Time Prediction for given hill height and climb"),
  
  # Sidebar with options selectors 
  sidebarLayout(
    sidebarPanel(
      helpText("This application predicts the time taken to climb a hill given its height and climb."),
      h3(helpText("Select:")),
      sliderInput("dist", label = h4("Distance"), min=0,max=1000,value = 0),
      sliderInput("climb", label = h4("Climb"),min=0,max=1000,value = 0))
    ,
    
    # Show a plot with hills and regression line
    mainPanel(
      plotOutput("distPlot"),
      h4("Predicted time to climb this hill is:"),
      h3(textOutput("result"))
    ))
    )
  )