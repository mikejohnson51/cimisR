#' @title Find CIMIS Stations
#' @description \code{findCIMIS} returns a \code{SpatialPointsDataFrame}
#' of all California Department of Water Resources CIMIS stations for an Area of Interest. This dataset is accessed through the CIMIS FTP 
#' and contains the following attributes:
#' \itemize{
#' \item 'Station Number':      \code{character}  Unique Station ID
#' \item 'DWR Regional Office': \code{character}  Department of Water Resources Regional Office
#' \item 'Name':                \code{character}  Station Name
#' \item 'County':              \code{character}  Station County
#' \item 'Latitude':            \code{numeric}    Station latitude, decimil degrees
#' \item 'Longitude':           \code{numeric}    Station longitude, decimil degrees
#' \item 'Elevation':           \code{numeric}    Station Elevation (meters)
#' \item 'Status':              \code{logical}    Is the station active?
#' \item 'Connect':             \code{Date}       Date of first observation
#' \item 'Disconnect':          \code{Date}       Date of last observation
#' } \cr
#' @param AOI A Spatial* or simple features geometry, can be piped from \link[AOI]{getAOI}
#' @param ids If TRUE, a vector of CIMIS station IDs are added to retuned list (default = \code{FALSE})
#' @return a list() of minimum length 2: AOI and nwis
#' @examples
#' \dontrun{
#' sb.cimis = getAOI(state = "CA", county = 'Santa Barbara') %>% findCIMIS()
#' }
#' @author Mike Johnson
#' @export

findCIMIS = function(AOI = NULL, ids = FALSE) {
  `%+%` = crayon::`%+%`
  
  if (!(class(AOI) %in% c("list"))) {
    AOI = list(AOI = AOI)
  }
  
  load("/Users/mikejohnson/Documents/GitHub/cimisR/data/station_meta.rda")
  
  sp = sf::st_as_sf(
    x = cimis,
    coords = c("longitude", "latitude"),
    crs = 4269
  ) %>% sf::as_Spatial()
  
  sp = sp[AOI$AOI, ]
  
  if (dim(sp)[1] == 0) {
    warning("0 stations found in AOI")
  } else {
    AOI[["cimis"]] = sp
    
    report = paste(length(sp), "CIMIS stations")
    
    if (ids) {
      AOI[['station.ids']] = AOI$cimis$station.number
      report = append(report, "list of station IDs")
    }
    
    if (length(report) > 1) {
      report[length(report)] = paste("and",  tail(report, n = 1))
    }
  }
  
  cat(crayon::white("Returned object contains: ") %+% crayon::green(paste(report, collapse = ", "), "\n"))
  
  return(AOI)
  
}

