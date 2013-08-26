library(shiny)
library(ShinyDash)
library(XML)
library(httr)

shinyServer(function(input, output, session) {
  
  all_values <- 100  # Start with an initial value 100
  max_length <- 80   # Keep a maximum of 80 values
  
  # Collect new values at timed intervals and adds them to all_values
  # Returns all_values (reactively)
  values <- reactive({
    # Set the delay to re-run this reactive expression
    invalidateLater(input$delay, session)
    
    # Generate a new number
    isolate(new_value <- last(all_values) * (1 + input$rate + runif(1, min = -input$volatility, max = input$volatility)))
    
    # Append to all_values
    all_values <<- c(all_values, new_value)
    
    # Trim all_values to max_length (dropping values from beginning)
    all_values <<- last(all_values, n = max_length)
    
    all_values
  })
  
  
  output$weatherWidget <- renderWeather(2487956, "f", session=session)
  
  # Set the value for the gauge
  # When this reactive expression is assigned to an output object, it is
  # automatically wrapped into an observer (i.e., a reactive endpoint)
  output$live_gauge <- renderGauge({
    running_mean <- mean(last(values(), n = 10))
    round(running_mean, 1)
  })
  
  # Output the status text ("OK" vs "Past limit")
  # When this reactive expression is assigned to an output object, it is
  # automatically wrapped into an observer (i.e., a reactive endpoint)
  output$status <- reactive({
    running_mean <- mean(last(values(), n = 10))
    if (running_mean > 200)
      list(text="Past limit", widgetState="alert", subtext="", value=running_mean)
    else if (running_mean > 150)
      list(text="Warn", subtext = "Mean of last 10 approaching threshold (200)",
           widgetState="warning", value=running_mean)
    else
      list(text="OK", subtext="Mean of last 10 below threshold (200)", value=running_mean)
  })
  
  
  # Update the latest value on the graph
  # Send custom message (as JSON) to a handler on the client
  sendGraphData("live_line_graph", {
    list(
      # Most recent value
      y0 = last(values()),
      # Smoothed value (average of last 10)
      y1 = mean(last(values(), n = 10))
    )
  })
  
})


# Return the last n elements in vector x
last <- function(x, n = 1) {
  start <- length(x) - n + 1
  if (start < 1)
    start <- 1
  
  x[start:length(x)]
}
