library(ShinyDash)

statusOutput <- function(outputId) {
  tags$div(id=outputId, class="status_output",
           tags$div(class = 'grid_bigtext'),
           tags$p()
  )
}

justgageOutput <- function(outputId, width, height) {
  tags$div(id = outputId, class = "justgage_output", style = sprintf("width:%dpx; height:%dpx", width, height))
}


shinyUI(bootstrapPage(
  h1("ShinyDash Example"),
  
  gridster(width = 250, height = 250,
    gridsterItem(col = 1, row = 1, sizex = 1, sizey = 1,
                
                sliderInput("rate", "Rate of growth:",
                            min = -0.25, max = .25, value = .02, step = .01),
                
                sliderInput("volatility", "Volatility:",
                            min = 0, max = .5, value = .25, step = .01),
                
                sliderInput("delay", "Delay (ms):",
                            min = 250, max = 5000, value = 3000, step = 250),
                
                tags$p(
                  tags$br(),
                  tags$a(href = "https://github.com/wch/shiny-jsdemo", "Source code")
                )
    ),
    gridsterItem(col = 2, row = 1, sizex = 2, sizey = 1,
                tags$div(id = "live_highchart",
                         style="min-width: 200px; height: 230px; margin: 0 auto"
                )
    ),
    gridsterItem(col = 1, row = 2, sizex = 1, sizey = 1,
                justgageOutput("live_gauge", width=250, height=200)
    ),
    gridsterItem(col = 2, row = 2, sizex = 1, sizey = 1,
                tags$div(class = 'grid_title', 'Status'),
                statusOutput('status')
    ),
    gridsterItem(col = 3, row = 2, sizex = 1, sizey = 1,
                plotOutput("plotout", height = 250)
    )
  )
))