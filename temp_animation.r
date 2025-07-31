# ===============================================================================
# Temperature Data Visualization and Animation Script
# ===============================================================================
# Load required libraries
library(ncdf4)     # For reading NetCDF files
library(fields)    # For color scales and image plotting functions
library(animation) # For creating animated GIFs
library(maps)      # For world map overlays
library(sf)        # For spatial data handling

# ===============================================================================
# DATA IMPORT AND PREPROCESSING
# ===============================================================================

# Open the NetCDF file containing temperature data
nc_file <- nc_open("data_stream-moda.nc") #use your download file name

# Extract coordinate variables from the NetCDF file
lon <- ncvar_get(nc_file, "longitude")    # Longitude coordinates
lat <- ncvar_get(nc_file, "latitude")     # Latitude coordinates  
time <- ncvar_get(nc_file, "valid_time")  # Time coordinates

# Convert time from Unix timestamp to POSIXct format for easier handling
time_posix <- as.POSIXct(time, origin = "1970-01-01", tz = "UTC")

# Extract temperature data and convert from Kelvin to Celsius
# Note: ERA5 data is typically in Kelvin, so we subtract 273.15
t2m <- ncvar_get(nc_file, "t2m") - 273.15  # Convert all data to °C at once

# Close the NetCDF file to free memory
nc_close(nc_file)

# ===============================================================================
# COLOR SCALE SETUP
# ===============================================================================

# Calculate global temperature range for consistent color scaling across all frames
global_min <- min(t2m, na.rm = TRUE)
global_max <- max(t2m, na.rm = TRUE)

# Create temperature breaks for color mapping (65 breaks for 64 color intervals)
temp_breaks <- seq(floor(global_min), ceiling(global_max), length.out = 65)

# ===============================================================================
# PLOTTING FUNCTION
# ===============================================================================

# Custom plotting function with enhanced styling and layout
plot_temperature <- function(time_index) {
  # Extract temperature data for the specified time slice
  # Reorder latitude data to ensure proper orientation (south to north)
  temp_ordered <- t2m[, order(lat), time_index]
  
  # Configure plot margins and text sizing for optimal layout
  par(mar = c(3.2, 3, 4, 5) + 0.1,  # Custom margins: bottom, left, top, right
      cex.axis = 0.6,                # Smaller axis label text
      tck = -0.02,                   # Shorter tick marks
      mgp = c(1.5, 0.3, 0))         # Axis label positioning
  
  # Create the main temperature image plot
  image(lon, sort(lat), temp_ordered,
        col = tim.colors(64),        # Use 64-color temperature palette
        breaks = temp_breaks,        # Apply consistent color breaks
        xlab = "", ylab = "",        # No axis labels (added separately)
        main = paste("2m Temperature at", format(time_posix[time_index], "%Y-%m-%d %H:%M UTC")),
        xlim = range(lon), ylim = range(lat),
        cex.main = 1.1,             # Slightly larger title text
        axes = FALSE)               # Custom axes added below
  
  # Add custom-styled coordinate axes
  axis(1, cex.axis = 0.6, tck = -0.02, mgp = c(1.5, 0.3, 0))  # X-axis (longitude)
  axis(2, cex.axis = 0.6, tck = -0.02, mgp = c(1.5, 0.3, 0))  # Y-axis (latitude)
  
  # Add color legend bar with custom positioning and styling
  image.plot(zlim = c(global_min, global_max),
             legend.only = TRUE,      # Only draw the legend, not the image
             col = tim.colors(64),
             breaks = temp_breaks,
             smallplot = c(0.88, 0.90, 0.2, 0.8),  # Legend position (x1, x2, y1, y2)
             legend.args = list(text = "Temperature (°C)", side = 4, 
                                font = 2, line = 1.5, cex = 0.7),  # Legend title
             axis.args = list(cex.axis = 0.7,      # Legend axis styling
                              tck = -0.3,
                              mgp = c(3, 0.3, 0)))
  
  # Add data source attribution
  mtext("Data: Copernicus Climate Change Service (C3S)", 
        side = 1, adj = 1, line = 1.8, cex = 0.7, col = "gray40")
  
  # ===============================================================================
  # MAP OVERLAY ELEMENTS
  # ===============================================================================
  
  # Add world map boundaries with high resolution if available
  if("mapdata" %in% installed.packages()) {
    library(mapdata)
    map("worldHires", add = TRUE, col = "black", lwd = 0.5)  # High-res coastlines
  } else {
    map("world", add = TRUE, col = "black", lwd = 0.5)       # Standard resolution
  }
  
  # Add coordinate grid for reference
  grid(col = "gray", lty = "dotted")
  
  # Add country borders with thicker lines for better visibility
  map("world", add = TRUE, col = "gray30", lwd = 1.5)
  
  # Add plot border
  box()
}

# ===============================================================================
# TESTING AND ANIMATION CREATION
# ===============================================================================

# Test the plotting function with the first time step
plot_temperature(1)

# Create animated GIF from temperature data
# Note: Limited to first 10 time steps for demonstration purposes
saveGIF({
  for (i in 1:min(dim(t2m)[3], 10)) {  # Loop through available time steps (max 10)
    plot_temperature(i)
  }
}, movie.name = "temperature_animation_final.gif", 
interval = 0.5,      # 0.5 seconds between frames
ani.width = 1200,    # Animation width in pixels
ani.height = 800,    # Animation height in pixels
ani.res = 150)       # Resolution (DPI) for high-quality output
