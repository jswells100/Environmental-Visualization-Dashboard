# Environmental Visualization Dashboard

An interactive R Shiny app that analyzes carbon emissions and forest cover trends for the 50 U.S. States, and forest loss trends for 200+ countries and global regions.

## The App
[Find the App Here](https://jswells.shinyapps.io/Environmental_Visualization/)

## The Goal of the App

On this dashboard, the user can view environmental trends across time:

 1. All 50 U.S. States have carbon emissions and forest cover trends, starting in the early 2000's
 2. 200+ countries, territories, and geographic/economic/political regions are included in global data on forest loss starting in the early 1990's

The code is written to handle 500+ automated time series graphs and interactive inputs.

## Features

Landing Page for United States Trends <img width="1440" height="776" alt="Screenshot 2025-11-11 at 2 27 55 PM" src="https://github.com/user-attachments/assets/ef8ee592-62c7-4f0d-9119-c145cb200960" />

Landing Page for International Trends <img width="1440" height="778" alt="Screenshot 2025-11-11 at 3 59 16 PM" src="https://github.com/user-attachments/assets/5344d956-b28c-4ccd-9990-3255fd75a166" />

### Libraries Used

  1. readxl: Selectively import multi-sheet excel datasets
  2. tidyr: Reshape data into analysis-ready format
  3. dplyr: Create columns & filter values in reshaped data and join domestic data
  4. stringr: Efficiently extract years from initial datasets
  5. ggplot2: Simple, clean visualizations of relevant trends
  6. gridExtra: Simultaneously display domestic forest and carbon data if the user requests
  7. Shiny: Construct an intuitive, interactive UI

### Interactivity

  1. An explanation tab provides basic background on the app's purpose, structure, and data used
  2. Tabs allows users to switch between domestic (U.S.) or international scopes
  3. Dropdown menus let users select states, countries, and regions to toggle between
  4. Sliders provide year ranges for users to select
  5. Checkboxed allows users to toggle which trends to display on the domestic tab

### Automation

  1. 500+ time series visualizations across states and countries
  2. Predefined ggplot template for visual consistency across graphs
  3. Safety checks to ensure trend data exists within the year range specified by the user
  4. Cleaned and combined separate sheets for domestic data

## Data Pipeline

### First, in functionsfinal.R:

  1. Write a function "lengthen" to convert domestic data into a clean, analysis ready form
  2. 
## What's in This Repository?

Included in this repository are:

  1. functionsfinal.R, a script containing functions concerning data wrangling and time series graph automation,
  2. app.R, a script that reads in the necessary datasets, sources and applies the functions from functionsfinal.R onto the datasets, and creates the UI for the app,
  3. forestlossworld.csv and accompanying metadata files from FAOSTAT, which contain the raw data on international forest cover loss,
  4. usaforestloss.xlsx from the Global Forest Watch, which contains the raw state-level carbon emissions and forest loss data,

## A Note on This Project
This app was my final project in STAT 6365: Modern Statistical Programming, a second programming course at UGA teaching intermediate R and introductory Python in the context of data manipulation and visualization.

