#' @title CIMIS Station Metadata
#' @description Dataset cimis \code{SpatialPolygons} of USA States. Data is initalized from the USAboundaries and USAboundariesData
#' package, converted to \code{SpatialPolygons}, re-projected and cleaned-up for this package. The primary reason for doing this is to provide
#' a more minimalistic dataset primed for this package and leaflet use.
#' @docType data
#' @format a \code{SpatialPolygonsDataFrame}, 52 observations of 5 variables:
#' \itemize{
#' \item 'siteID'          :  \code{character}  Unique station id
#' \item 'Regional Office' :  \code{character}  Regional office maintaining station
#' \item 'name'            :  \code{character}  Name of station
#' \item 'county'          :  \code{character}  California county station is in
#' \item 'latitude'        :  \code{numeric}    Latitiude, decimil degree
#' \item 'longitude'       :  \code{numeric}    Longitude, decimil degree
#' \item 'elevation'       :  \code{numeric}    Elevation in meters
#' \item 'status'          :  \code{logical}    Is the station active?
#' \item 'startDate'       :  \code{Date}       Date of first observation
#' \item 'endDate'         :  \code{Date}       Date of last observation
#' }
#' @examples
#' \dontrun{
#' cimisR::cimis
#'}

"cimis"

