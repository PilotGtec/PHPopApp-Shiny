library(shiny)
library(maps)
library(googleVis)
library(datasets)

df <- read.csv("pop2010.csv")

shinyServer( function(input, output) {
    variable <- reactive({switch(input$choice,
                                 "Population" = "pop",
                                 "Population Density" = "popden")})
    
    output$gvis <- renderGvis({
        o <- variable()
        if(o=="pop") {
            print("pop")
            output$header <- renderText({paste("Population")})
            output$subheader <- renderText({paste("")})
            plotme <- data.frame(df$Code, df$Pop2010)
            colnames(plotme) <- c("region", "value")
        }
        
        if(o=="popden") {
            print("popDen")
            output$header <- renderText({paste("Population Density")})
            output$subheader <- renderText({paste("The population density of the National Capital Region
                                                  where Metro Manila is at least two orders of 
                                                  magnitude greater than the rest of the regions.")})
            plotme <- data.frame(df$Code, df$PopDen2010)
            colnames(plotme) <- c("region", "value")
        }
        
        print (plotme)
        
        gvisGeoChart(plotme, "region", "value", 
                     options=list(region="PH", resolution="provinces", title="Philippine Population",
                                  width=600, height=400))
        #         names(stateData)[2] <- "value"
        #         generate the choropleth
        #         data(stateMapEnv)
        #         stateData$state.abb <- state.abb[match(USArrests$State, state.name)]
        #         gvisGeoChart(stateData, "state.abb", "value", options=list(
        #             region="US", displayMode="regions", resolution="provinces"))
        #         gvisGeoChart(LifeCycleSavings, "countries", "sr", 
        #                      options=list(title="Life Cycle Savings",
        #                                   projection="kavrayskiy-vii"))
    })
    
    newdf <- data.frame(df$Code, df$Name, df$Pop2010, df$PopDen2010)
    colnames(newdf) <- c( "ISO 3166-2:PH", "Region Name", "Population", "Population Density")
    output$RegCodes <- renderDataTable(newdf, options = list(pageLength=10))
    
} )