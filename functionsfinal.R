library(tidyverse)
library(readxl)
library(gridExtra)

#CONVERT FROM WIDE TO LONG FORMAT

lengthen=function(data,value_name,columns){
  long=data %>%
    pivot_longer(
      cols=all_of(columns),
      names_to='year',
      values_to=value_name
    ) %>%
    mutate(
      year=str_extract(year,'\\d{4}'),
      year=as.integer(year)
    )
  return(long)
}


#TAKE THE PIVOTED DATA AND TURN THEM INTO A SINGLE DATASET
recombine=function(carbondata,lossdata){
  carboncol=paste0('gfw_forest_carbon_gross_emissions_',2001:2024,'__Mg_CO2e')
  losscol=paste0('tc_loss_ha_',2001:2024)
  
  carbon_long=lengthen(carbondata,'carbon_emissions',carboncol)
  loss_long=lengthen(lossdata,'forest_loss',losscol)
  
  full_join(carbon_long,loss_long,by=c('subnational1','year'))
}

#FILTER BY STATE AND YEAR RANGE

plot_state_trends=function(data,state,metrics,year_range){
  finaldata=data %>%
    filter(
      subnational1==state,
      year>=year_range[1],
      year<=year_range[2]
    )
  
  #CREATE EMPTY LIST FOR LINE GRAPHS
  
  lines=list()
  
  #CARBON EMISSIONS LINE GRAPHS
  #NOTE THAT WE CHECK TO SEE IS THIS STATE AND YEAR RANGE HAS DATA
  
  if('Carbon Emissions (Gross)' %in% metrics){
    lines[[length(lines)+1]]=ggplot(finaldata,aes(x=year,y=carbon_emissions))+
      geom_line(color='dodgerblue')+
      labs(
        x='Year',
        y='Carbon Emissions (Mg CO2e)',
        title=paste('Gross Carbon Emissions for',state),
      )+
      theme_bw()
  }
  
  #TREE COVER LOSS LINE GRAPH
  #NOTE THAT WE CHECK TO SEE IS THIS STATE AND YEAR RANGE HAS DATA
  
  if('Tree Cover Loss' %in% metrics){
    lines[[length(lines)+1]]=ggplot(finaldata,aes(x=year,y=forest_loss))+
      geom_line(color='seagreen')+
      labs(
        x='Year',
        y='Tree Cover Loss (Hectares)',
        title=paste('Tree Cover Loss',state),
      )+
      theme_bw()
  }
  
  do.call(grid.arrange,c(lines,ncol=1))
}


reshape_world_forest_area=function(data){
  data_long=data %>%
    pivot_longer(
      cols=paste0(1990:2022),
      names_to='year',
      values_to='forest_area_percent'
    ) %>%
    mutate(
      year=as.integer(year),
      forest_area_percent=as.numeric(forest_area_percent)
    ) %>%
    filter(!is.na(forest_area_percent))
  
  return(data_long)
}


plot_world_forest_area=function(data,country,year_range){
  filtered=data %>%
    filter(`Country Name`==country,
           year>=year_range[1],
           year<=year_range[2])
  
  ggplot(filtered,aes(x=year,y=forest_area_percent))+
    geom_line(color='dodgerblue',size=1)+
    labs(
      x='Year',
      y='Forest Area(%)',
      title=paste('Forest Area (% of Land) in',country)
    )+
    theme_bw()
}