# Monthly Temperature Animation Map 🌡️

A dynamic visualization of 2-meter temperature patterns across South Asia using R and Copernicus Climate Data Store.

## 📋 Overview

This project creates an animated temperature map showing monthly temperature variations across South Asia and surrounding regions. The visualization transforms complex meteorological data from the Copernicus Climate Change Service into an intuitive, color-coded animation that reveals seasonal temperature patterns and regional climate dynamics.

## 🎯 Key Features

- **Monthly Animation**: Dynamic visualization showing temperature changes throughout the year
- **Temperature Range**: Comprehensive scale from -30°C to +40°C with intuitive color gradients
- **Geographic Coverage**: Detailed mapping of South Asia with precise country boundaries
- **High-Quality Data**: Utilizes authentic climate data from Europe's premier climate monitoring service
- **Professional Visualization**: Clean, publication-ready maps with proper legends and annotations

## 📊 Data Source

- **Provider**: Copernicus Climate Change Service (C3S)
- **Dataset**: ERA5 Reanalysis - 2m Temperature
- **Temporal Coverage**: Monthly data
- **Spatial Resolution**: High-resolution gridded data
- **Access**: [Copernicus Climate Data Store](https://cds.climate.copernicus.eu/)

## 🛠️ Technologies Used

- **R Programming Language**
- **Key R Packages**:
  - `raster` / `terra` - Spatial data handling
  - `ggplot2` - Data visualization
  - `gganimate` - Animation creation
  - `sf` - Spatial features
  - `viridis` / `RColorBrewer` - Color palettes
  - `maps` / `rnaturalearth` - Geographic boundaries

## 🚀 Getting Started

### Prerequisites

```r
# Install required packages
install.packages(c("raster", "ggplot2", "gganimate", "sf", "viridis", "maps"))
```

### Usage

1. **Download Climate Data**: Access data from Copernicus Climate Data Store
2. **Data Processing**: Load and process NetCDF files using R
3. **Visualization**: Create static maps and animations
4. **Export**: Generate high-quality output files

```r
# Basic workflow example
library(raster)
library(ggplot2)
library(gganimate)

# Load temperature data
temp_data <- stack("temperature_data.nc")

# Create animation
temp_animation <- animate_temperature_map(temp_data)
```

## 📈 Results

The temperature animation reveals:

- **Temperature Gradients**: Clear visualization of temperature variations across the region
- **Seasonal Patterns**: Dynamic monthly changes throughout the year  
- **Regional Differences**: Distinct climate zones from cold mountainous areas to hot tropical regions
- **Climate Dynamics**: Enhanced understanding of regional weather patterns

## 🎨 Visualization Highlights

- **Color Scheme**: Blue (cold) to red (hot) gradient for intuitive interpretation
- **Geographic Accuracy**: Precise country and regional boundaries
- **Temporal Resolution**: Monthly data showing seasonal transitions
- **Professional Quality**: Publication-ready maps with proper legends

## 📁 Repository Structure

```
├── data/
│   ├── raw/                 # Original NetCDF files
│   └── processed/           # Cleaned and processed data
├── scripts/
│   ├── data_processing.R    # Data cleaning and preparation
│   ├── visualization.R      # Map creation functions
│   └── animation.R          # Animation generation
├── output/
│   ├── static_maps/         # Individual monthly maps
│   └── animations/          # Animated GIF/MP4 files
└── README.md
```

## 🤝 Contributing

Contributions are welcome! Please feel free to:
- Report bugs or issues
- Suggest new features
- Submit pull requests
- Share feedback on visualizations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Copernicus Climate Change Service (C3S)** for providing high-quality climate data
- **European Centre for Medium-Range Weather Forecasts (ECMWF)** for data infrastructure
- **R Community** for excellent spatial analysis and visualization packages

## 📧 Contact

Feel free to reach out for questions, collaborations, or feedback!

---

*Making climate data accessible through visualization* 🌍
