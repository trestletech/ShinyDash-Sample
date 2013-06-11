library(shiny)
library(ShinyDash)

shinyUI(bootstrapPage(
  h1("ShinyDash Example"),
  
  gridster(tile.width = 250, tile.height = 250,
    gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
                
                sliderInput("rate", "Rate of growth:",
                            min = -0.25, max = .25, value = .02, step = .01),
                
                sliderInput("volatility", "Volatility:",
                            min = 0, max = .5, value = .25, step = .01),
                
                sliderInput("delay", "Delay (ms):",
                            min = 250, max = 5000, value = 3000, step = 250),
                
                tags$p(
                  tags$br(),
                  tags$a(href = "https://github.com/trestletech/ShinyDash-Sample", "Source code")
                )
    ),
    gridsterItem(col = 2, row = 1, size.x = 2, size.y = 1,
                lineGraphOutput("live_line_graph",
                         width=532, height=250, axisType="time", legend="topleft"
                )
    ),
    gridsterItem(col = 1, row = 2, size.x = 1, size.y = 1,
                gaugeOutput("live_gauge", width=250, height=200, units="CPU", min=0, max=200, title="Cost per Unit")
    ),
    gridsterItem(col = 2, row = 2, size.x = 1, size.y = 1,
                tags$div(class = 'grid_title', 'Status'),
                htmlWidgetOutput('status', 
                                 tags$div(id="text", class = 'grid_bigtext'),
                                 tags$p(id="subtext"),
                                 tags$p(id="value", 
                                        `data-filter`="round 2 | prepend '$' | append ' cost per unit'",
                                        `class`="numeric"))
    ),
    gridsterItem(col = 3, row = 2, size.x = 1, size.y = 1,
                weatherWidgetOutput("weatherWidget", width="100%", height="90%")
    )
  )
))