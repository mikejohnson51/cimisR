cimis.daily.pre2014 = data.frame(
  Field = c(
    "Station Id",  "Date", "Julian",
    "QC for Solar Radiation Average",   "Solar_Radiation_Average",
    "QC for Average Soil Temperature",  "Average Soil Temperature",
    "QC for Maximum Air Temperature",   "Maximum_Temperature",
    "QC for Minimum Air Temperature",   "Minimum_Temperature",
    "QC for Average Air Temperature",   "Average_Temperature",
    "QC for Average Vapor Pressure",    "Average_Vapor_Pressure",
    "QC for Average Wind Speed",        "Average Wind Speed",
    "QC for Precipitation",             "Precipitation",
    "QC for Maximum Relative Humidity", "Maximum_Relative_Humidity",
    "QC for Minimum Relative Humidity", "Minimum_Relative_Humidity",
    "QC for Reference ETo",             "Reference_ETo",
    "QC for Average Relative Humidity", "Average Relative Humidity",
    "QC for Dew Point",                 "Dew Point",
    "QC for Wind Run",                  "Wind Run" ),
  
  SI.units = c(
   NA, NA, NA,
   NA, "Ly/day",
   NA, "∞F",
   NA, "∞F",
   NA, "∞F",
   NA, "∞F",
   NA, "mBars",
   NA, "mph",
   NA, "in/day",
   NA,"%",
   NA,"%",
   NA, "in/day",
   NA,"%",
   NA, "∞F",
   NA, "miles"
  ),
  
  Metric.units = c(
    NA, NA, NA,
    NA, "W/m2",
    NA, "∞C",
    NA, "∞C",
    NA, "∞C",
    NA, "∞C",
    NA, "kPa",
    NA, "m/s",
    NA, "mm/day",
    NA,"%",
    NA,"%",
    NA, "mm/day",
    NA,"%",
    NA, "∞C",
    NA, "km"
  ),
  stringsAsFactors = FALSE
)

cimis.daily.post2014 = cimis.daily.pre2014[c(1,2,3,25,24,19,18,5,4,15,14,9,8,11,10,13,12,21,20,23,22,27,26,29,28,17,16,31,30,7,6),]
