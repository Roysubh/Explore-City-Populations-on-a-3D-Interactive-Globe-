Explore City Populations on a 3D Interactive Globe 🌍
This project visualizes global city populations on a 3D interactive globe using R and threejs.
Cities are color-coded based on population categories, providing an engaging way to explore urban density worldwide.

Overview:
With urbanization accelerating, understanding population distributions is vital. 
This interactive 3D globe offers a simple yet powerful way to visualize and explore the sizes of cities around the world.
By color-coding cities according to population ranges, users can quickly identify densely populated areas, mid-sized urban centers, and smaller cities, allowing for insights into global population distribution patterns.

Features:
Interactive 3D globe with cities represented by color-coded markers
  1. Categories by population:
      100k-500k: Light red (#fcae91)
      500k-1M: Medium red (#fb6a4a)
      1M-5M: Dark red (#de2d26)
      >5M: Darkest red (#a50f15)
  2. Legend overlay for quick reference of population categories

Prerequisites:
  1. threejs for 3D globe visualization
  2. dplyr for data manipulation
  3. maps for accessing city data
  4. scales for scaling values

Data Source:
The world city population data is sourced from the maps package in R. More information on the dataset can be found on the CRAN maps package page.

Conclusion:
This 3D interactive globe offers an intuitive way to explore urban populations worldwide.
By visualizing cities with varying population densities, the map helps reveal population patterns across continents. 
This project can serve as a foundation for further analysis or visualization of global population dynamics.
