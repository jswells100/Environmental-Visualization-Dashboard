library(shiny)
library(tidyverse)
library(readxl)
source('functionsfinal.R')

subnat_carbon=read_excel('usaforestloss.xlsx',sheet='Subnational 1 carbon data') %>%
  filter(`umd_tree_cover_density_2000__threshold`==30)

subnat_loss=read_excel('usaforestloss.xlsx',sheet='Subnational 1 tree cover loss') %>%
  filter(threshold==30)

forestlossworld=read_csv('forestlossworld.csv',na='',skip=4)
forestlossworld=reshape_world_forest_area(forestlossworld)

joined=recombine(subnat_carbon,subnat_loss)

ui=navbarPage('Visualizing Forest and Carbon Data',
              
              tabPanel('United States',
                       fluidPage(
                         titlePanel('Tree Cover Loss and Carbon Emissions by State'),
                         helpText('See `United States: A Note on the Graphs`, for a discussion on the graphs'),
                         sidebarLayout(
                           sidebarPanel(
                             selectizeInput(
                               'state','Choose a State:',
                               choices=sort(unique(joined$subnational1)),
                               selected='Georgia'),
                             checkboxGroupInput(
                               'metrics','Choose a Metric:',
                               choices=c('Carbon Emissions (Gross)','Tree Cover Loss'),
                               selected=c('Carbon Emissions (Gross)','Tree Cover Loss')),
                             sliderInput('year_range','Select Year Range:',
                                         min=2001,max=2024,
                                         value=c(2001,2024),sep='')
                           ),
                           mainPanel(
                             plotOutput('trendPlot')
                           )
                         )
                       )
              ),
              
              tabPanel('World Forest Area',
                       fluidPage(
                         titlePanel('Forest Area by Country'),
                         helpText('See `World Forest Area: A Note on the Graphs` for a discussion on the graphs'),
                         sidebarLayout(
                           sidebarPanel(
                             selectizeInput(
                               'country','Choose a Country:',
                               choices=sort(unique(forestlossworld$`Country Name`)),
                               selected='United States'),
                             
                             sliderInput(
                               'world_year_range','Choose a Year Range:',
                               min=1990,max=2022,
                               value=c(1990,2022),sep=''),
                             
                           ),
                           mainPanel(
                             plotOutput('worldPlot')
                           )
                         )
                       )
              ),
              
              tabPanel('Explanation for Tabs',
                       fluidPage(
                         titlePanel('About This App'),
                         tags$h3('United States'),
                         tags$b('About This Tab'),
                         p('This tab explores data provided by the Global Forest Watch. 
                           You can analyze tree cover loss and gross carbon emissions data 
                           for each state in the United States.'), 
                         tags$b('About the Tree Cover Data'),
                         p('The data on tree cover loss is courtesy of the GLAD 
                           laboratory at the University of Maryland. This graph 
                           measures tree cover loss in hectares at the 30% tree canopy cover level.
                           Note that tree cover includes all vegetation taller than 5 meters, and that
                           tree cover loss is simply the removal of tree cover for any reason. This 
                           extends beyond deforestation.'),
                         tags$b('About the Carbon Emissions Data'),
                         p('The data on carbon emissions is courtesy of Harris et. al. 2021, published
                           in Nature Climage Change. This data looks at several metric related to Carbon.
                           The most familiar component is average annual greenhouse gas emissions,
                             but also includes carbon sequestration and flux. This is measured in megagrams per CO2 equivalent.
                             This is also at the 30% tree canopy cover level.'),
                         tags$b('A Note on the Graphs'),
                         p('Also note that deforestation is a major component of tree cover loss, but also a major source of carbon emissions. So, it is not necessarily incorrect for the two graphs to seem similar in shape.'),
                         
                         tags$h3('World Forest Area'),
                         tags$b('About This Tab'),
                         p('This tab explores data provided by the World Bank. You can analyze
                            tree cover loss for several entities. While most options are countries, there are also territories and dependencies. Similarly, you can select certain regions, aggregates, or other specialized inputs.'),
                         tags$b('About This Data'),
                         p('This data is compiled by FAOSTAT in the Food and 
                           Agriculture Organization. You can select which country or entity you would like to explore.
                           The graph measures tree cover loss for the selected entity, where tree cover is again
                           vegetation taller than 5 meters.'),
                         tags$b('A Note on the Graphs'),
                         p('You may notice that some countries have graphs which change noticeably with each year, while some countries appear to stagnate at the same percentage each year.
                              While the official reasoning for this was not disclosed for data, it is not unreasonable to assume that FAOSTAT had difficulty collecting data in certain countries
                              each year, had to default to an average in certain countries, or other reasons. Further, you may notice that some countries have 0% forest cover, or do not have data starting at 1990. These are not errors.'),
                         
                         
                       )
              ))


server=function(input,output){
  output$trendPlot=renderPlot({
    plot_state_trends(
      data=joined,
      state=input$state,
      metrics=input$metrics,
      year_range=input$year_range
    )
  })
  
  output$worldPlot=renderPlot({
    plot_world_forest_area(
      data=forestlossworld,
      country=input$country,
      year_range=input$world_year_range
    )
  })
}


shinyApp(ui=ui,server=server)