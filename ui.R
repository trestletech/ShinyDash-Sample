library(ShinyDash)

statusOutput <- function(outputId) {
  tags$div(id=outputId, class="status_output",
           tags$div(class = 'grid_bigtext'),
           tags$p()
  )
}


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
                         width=532, height=250
                )
    ),
    gridsterItem(col = 1, row = 2, size.x = 1, size.y = 1,
                gaugeOutput("live_gauge", width=250, height=200)
    ),
    gridsterItem(col = 2, row = 2, size.x = 1, size.y = 1,
                tags$div(class = 'grid_title', 'Status'),
                statusOutput('status')
    ),
    gridsterItem(col = 3, row = 2, size.x = 1, size.y = 1,
                plotOutput("plotout", height = 250)
    )
  )
))