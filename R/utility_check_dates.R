check.dates = function(sid, req.start, req.end){

  sta.end = cimis$endDate[which(cimis$siteID == sid)]
  if(is.na(sta.end)){sta.end = Sys.Date()}
  sta.start = cimis$startDate[which(cimis$siteID == sid)]

  if(!is.null(req.start)){ con1 = (sta.start <= req.start) } else {con1 = TRUE}
  
  if(!is.null(req.end)){ con2 = (sta.end >= req.end) } else {con2 = TRUE}
 
  if(sum(con1, con2) == 2){ return(TRUE) } else {return(FALSE)}
}


