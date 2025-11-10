# Environmental Visualization Dashboard

This repository showcases an interactive R Shiny application that visualizes carbon emissions and forest cover trends on two different scopes: one tab allows users to investigate a particular state's trends, while a second tab allows users to select different countries or regions whose trends they want to view.

Included in this repository are:

  1. functionsfinal.R, a script containing functions concerning data wrangling and time series graph automation,
  2. app.R, a script that reads in the necessary datasets, sources and applies the functions from functionsfinal.R onto the datasets, and creates the UI for the app,
  3. forestlossworld.csv and accompanying metadata files from FAOSTAT, which contain the raw data on international forest cover loss,
  4. usaforestloss.xlsx and accompanying metadata files from the Global Forest Watch, which contain the raw state-level carbon emissions and forest loss data,
  5. The R Shiny application.

This app was my final project in STAT 6365: Modern Statistical Programming, a second programming course in UGA's Department of Statistics which teaches intermediate R and introductory Python in the context of data manipulation and visualization.
