#Install the required packages 
install.packages(c("threejs", "dplyr", "maps", "scales"))

# Load necessary libraries
library(threejs)    # For creating interactive 3D visualizations
library(dplyr)      # For data manipulation
library(maps)       # For accessing world cities data
library(scales)     # For rescaling population data to control point sizes

# Load world city data from the 'maps' package
data(world.cities, package = "maps")

# Step 1: Prepare data by categorizing cities based on population
# Remove cities with populations below 100,000
world_cities <- world.cities %>%
  mutate(
    population_category = cut(
      pop, 
      breaks = c(100000, 500000, 1000000, 5000000, Inf),  # Population ranges
      labels = c("100k-500k", "500k-1M", "1M-5M", "> 5M"),  # Category labels
      include.lowest = TRUE
    )
  )

# Step 2: Define a color palette for each population category
color_palette <- c("100k-500k" = "#fcae91",    # Light red for 100k-500k
                   "500k-1M" = "#fb6a4a",      # Medium red for 500k-1M
                   "1M-5M" = "#de2d26",        # Dark red for 1M-5M
                   "> 5M" = "#a50f15")         # Darker red for >5M

# Step 3: Assign colors to each city based on its population category
world_cities$color <- color_palette[world_cities$population_category]

# Step 4: Prepare latitude, longitude, and size for visualization
lat <- world_cities$lat      # Latitude of each city
lon <- world_cities$long     # Longitude of each city
size <- rescale(world_cities$pop, to = c(1, 4))  # Scale sizes for visualization

# Step 5: Create a 3D globe visualization with `threejs`
globe <- globejs(
  lat = lat,
  long = lon,
  value = size,
  color = world_cities$color,
  atmosphere = TRUE,
  pointsize = 1  # Point size to control visibility
)

# Step 6: Add a legend overlay to clarify population categories and color codes
globe <- htmlwidgets::onRender(globe, "
  function(el, x) {
    var legend = document.createElement('div');
    legend.innerHTML = `
      <style>
        .legend-container {
          position: absolute;
          bottom: 20px;
          left: 20px;
          background: rgba(255, 255, 255, 0.8);
          padding: 10px;
          border-radius: 5px;
        }
        .legend-item {
          display: flex;
          align-items: center;
          margin-bottom: 5px;
        }
        .legend-color {
          width: 12px;
          height: 12px;
          display: inline-block;
          margin-right: 8px;
        }
      </style>
      <div class='legend-container'>
        <strong>City Population</strong><br />
        <div class='legend-item'><span class='legend-color' style='background-color: #fcae91;'></span>100k-500k</div>
        <div class='legend-item'><span class='legend-color' style='background-color: #fb6a4a;'></span>500k-1M</div>
        <div class='legend-item'><span class='legend-color' style='background-color: #de2d26;'></span>1M-5M</div>
        <div class='legend-item'><span class='legend-color' style='background-color: #a50f15;'></span>> 5M</div>
      </div>
    `;
    el.appendChild(legend);
  }
")

# Step 7: Display the interactive globe
globe

# Step 8: Save the visualization as an HTML file for easy sharing or web embedding
htmlwidgets::saveWidget(globe, "City_Population.html", selfcontained = FALSE)
