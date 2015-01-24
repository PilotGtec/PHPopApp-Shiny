library(shiny) 

shinyUI(
    pageWithSidebar(
        headerPanel("2010 Philippine Population"),
        sidebarPanel(
            p("The Philippines is composed of 7,107 islands and 
              is divided into 17 administrative regions. Here, we look at how 
              the popluation is distributed across the islands."),
            selectInput("choice", "Select a Population Measure:",
                        choices = c("Population", "Population Density")),
            p(a("Click here to read more about the app.", href="http://rpubs.com/PilotGtec22/53965"))),
        mainPanel(h3(textOutput("header")),
                  p(textOutput("subheader")),
                  #p(uiOutput("avg")),
                  #p(uiOutput("sd")),
                  #p("Hover over a state to see the number of arrests. The horizontal bar below the chart shows the max & min values."),
                  htmlOutput("gvis"),
                  h3("Data Table"),
                  p("Here we list the equivalent code needed to plot the values on the map."),
                  dataTableOutput("RegCodes")
        )       
    ))

