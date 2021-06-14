library(shiny)

jscode_redirect <- "Shiny.addCustomMessageHandler('redirect', function(redirect) { window.location = redirect;});"

shinyUI(fluidPage(
    tags$head(tags$script(jscode_redirect)),
    tags$script(src = "site.js"),
    titlePanel("샤이니코리아"),
    sidebarLayout(
        sidebarPanel(
            actionButton("login", "로그인"),
            actionButton("roadviewshow", "로드뷰 - 보이기"),
            actionButton("roadviewhide", "로드뷰 - 감추기"),
            actionButton("penTo", "위치이동"),
            actionButton("markershow", "마커표시"),
            
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            #includeHTML("html/distplot.html"),
            includeHTML("html/map.html"),
            textOutput("text"),
            verbatimTextOutput("queryText")
        )
    )
))
