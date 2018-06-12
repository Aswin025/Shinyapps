#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(MASS)
# select columns to be used in the analysis
h <- hills
# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    diam <- filter(hills, grepl(input$dist, dist), grepl(input$climb, climb))
    # build linear regression model
    fit <- lm(time ~ dist + climb , data=h)
    # predicts the time 
    pred <- predict(fit, newdata = data.frame(dist = input$dist,climb = input$climb))
    # Drow the plot using ggplot2
    plot <- ggplot(data=h, aes(x=dist, y = time))+
      geom_point(aes(color = climb), alpha = 0.3)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$dist, color = "red")+
      geom_hline(yintercept = pred, color = "green")+
      points(input$dist,pred)
    plot
  })
  output$result <- renderText({
    # renders the text for the prediction below the graph
    diam <- filter(hills, grepl(input$dist, dist), grepl(input$climb, climb))
    fit <- lm( time~dist+climb, h)
    pred <- predict(fit, newdata = data.frame(dist = input$dist,
                                              climb = input$climb))
    res <- paste(round(pred, digits = 2), "min")
    res
  })
  
})