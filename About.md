# About

The network development framework tool uses transit, bicycle theft, employment, and bicycle infrastructure data to help Oonee identify areas for expansion and planning in the New York City metropolitan area. The tool creates a score that weighs these criteria, revealing neighborhoods where secure bicycle parking could thrive. By using this tool, Oonee can strengthen public-private partnerships and add value to the station planning process with collaborators.

# Data sources

## Neighborhoods

-   [Neighborhood Tabulation Areas - NYC Open Data](https://data.cityofnewyork.us/City-Government/2020-Neighborhood-Tabulation-Areas-NTAs-Mapped/4hft-v355)

## Transit

-   [PATH Stations - Jersey City Open Data](https://data.jerseycitynj.gov/explore/dataset/path-stations/)

-   [Light Rail Stations of NJ Transit - NJGIN Open Data](https://njogis-newjersey.opendata.arcgis.com/maps/NJTRANSIT::light-rail-stations-of-nj-transit)

-   [MTA Subway Stations - NYC Open Data](https://data.cityofnewyork.us/Transportation/Subway-Stations/arq3-7z49)

-   [Metro-North Stations - NYC Mass Transit Spatial Layers Archive](https://www.baruch.cuny.edu/confluence/display/geoportal/NYC+Mass+Transit+Spatial+Layers+Archive)

-   [Long Island Rail Road - NYC Mass Transit Spatial Layers Archive](https://www.baruch.cuny.edu/confluence/display/geoportal/NYC+Mass+Transit+Spatial+Layers+Archive)

-   [NJT Commuter Rail Stations](https://hub.arcgis.com/maps/e6701817be974795aecc7f7a8cc42f79) - New Jersey Transit

## Bike Thefts

-   [NYPD Complaint Data Historic](https://data.cityofnewyork.us/Public-Safety/NYPD-Complaint-Data-Historic/qgea-i56i)

-   [NYPD Complaint Data Current (Year To Date)](https://data.cityofnewyork.us/Public-Safety/NYPD-Complaint-Data-Current-Year-To-Date-/5uac-w243)

## Jobs

-   [Longitudinal Employer-Household Dynamics Data](https://onthemap.ces.census.gov/)

## Bike infrastructure

-   [New York City Bike Routes - NYC Open Data](https://data.cityofnewyork.us/Transportation/New-York-City-Bike-Routes/7vsa-caz7)

-   [Bicycle Parking (racks and corrals) - NYC Open Data](https://data.cityofnewyork.us/Transportation/Bicycle-Parking/yh4a-g3fj)

-   [Bike Parking Shelters- NYC Open Data](https://data.cityofnewyork.us/Transportation/Bicycle-Parking-Shelters/thbt-gfu9)

## Bike Commuters

-   [American Community Survey, B08301: Means of Transportation to Work - U.S. Census Bureau](https://data.census.gov/table?q=B08301&g=050XX00US36005,36047,36061,36081,36085&tid=ACSDT1Y2021.B08301&moe=false)

# Methodology

The Network Development Index is created from five key indicators that, based on the Capstone team's research, may be good candidates for the development of a bike parking network. All metrics are summarized at the 2020 Neighborhood Tabulation Area geography. The five component indicators are compiled into an overall score.

1.  Transit score - neighborhoods receive points for each transit station in their neighborhood. They receive 3 points for a commuter rail station (Metro North or New Jersey Transit), 2 points for a subway "hub" with 4 lines or more, and 1 point for every subway or PATH station. Neighborhoods are then ranked by percentile of the cumulative transit score, leaving them with a transit score between 0 and 1. Neighborhoods with no transit stops receive 0 points.

2.  Bike thefts score - neighborhoods are ranked by percentile based on the number of bike thefts per capita, leaving them with a bike thefts score between 0 and 1.

3.  Jobs score - neighborhoods receive points for each job in their neighborhood. In order to focus on equity, we weighted jobs based on the income level. Each neighborhood receives 3 points for each low income job ($15K or below), 2 points for each middle income job ($15-$40K), and 1 point for each high income job ($40K+).Neighborhoods are then ranked by percentile of their cumulative job points, leaving them with a jobs score between 0 and 1.

4.  Bike infrastructure score - we measure the total length of bike lanes in each neighborhood, and count the total number of bike racks in each neighborhood. Neighborhoods are then ranked by percentile for the length of bike lanes, which comprises half of the bike infrastructure score. Neighborhoods are also ranked by the percentile for number of bike racks, which comprises the other half of the score. We add the bike lane percentile and the bike rack percentile together and then re-rank all neighborhoods based on that composite number for a bike infrastructure score between 0 and 1.

5.  Bike commuter score - we calculate the total number of bike commuters in each neighborhood, and then rank the neighborhoods by percentile to get a neighborhood bike commuter score between 0 and 1.

The total score is simply the sum of the five composite scores. Because each score is between 0 and 1, the total score is between 0 and 5.