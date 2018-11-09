#' @title Find Neareast CIMIS station(s)
#' @description \code{findNearestCIMIS} returns a \code{SpatialPointsDataFrame} of the 'n' number of CIMIS stations closest to a declared point.
#' @param point a point described by lat/long, can be piped from \link[AOI]{geocode}
#' @param n the number of stations to find (default = 5)
#' @param ids If TRUE, a vector of station IDs is added to retuned list (default = \code{FALSE})
#' @param bb If TRUE, the geometry of the minimum bounding area of the features is added to returned list  (default = \code{FALSE})
#' @export
#' @seealso findCIMIS
#' @return a list() of minimum length 2: AOI and cimis
#' @author Mike Johnson
#' @examples
#' \dontrun{
#' pt = geocode("UCSB") %>% findNearestCIMIS(n = 5)
#' }

findNearestCIMIS = function(point = NULL, n = 5, ids = FALSE, bb = FALSE){
  
  fin = list(loc = point)
  
  load("/Users/mikejohnson/Documents/GitHub/cimisR/data/station_meta.rda")
  df    = sf::st_as_sf(x = cimis,  coords = c("longitude", "latitude"), crs = 4269)
  point = sf::st_as_sf(x = point,  coords = c("lon", "lat"),            crs = 4269)
  dist  = data.frame(siteID = df$siteID, Distance_km = sf::st_distance(x = df, y = point))
  dist  = dist[order(dist$Distance_km)[1:n],]
  
  fin[["cimis"]] = as_Spatial(merge(df, dist, by = "siteID"))
  if (bb)  { fin[["AOI"]] = AOI::getBoundingBox(fin$cimis)}
  if (ids) { fin[["siteID"]] = unique(fin$cimis$siteID) }
  
  return(fin)
  
}
