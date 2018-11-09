get_cimis_yearToDate = function(station, units = "SI", startDate = NULL, endDate = NULL, rmflags = NULL, qc = FALSE){
  
  `%+%` = crayon::`%+%`
    
  vals = list()
  
  for(i in seq_along(station)){
  
  if(is.numeric(station[i])){ sid = sprintf("%03d", station[i])} else{ sid = station[i]}
    
  if(check.dates(sid, req.start = startDate , req.end = Sys.Date() - 365)){  
  
  cat(crayon::white("Processing data for station: ") %+% crayon::green(sid), '\n')
  
  if(units == 'metric'){ call = 'dailyMetric'} else {call = 'daily'}
  
  url = paste0('ftp://ftpcimis.water.ca.gov//pub2/', call, '/DayYrETo', sid, '.csv')
  
  xx = read.csv(url, header = FALSE, stringsAsFactors = FALSE)
  names(xx) = c("staID", "Date", "Julien", 'ETo', 'QC_ETo')
  xx$Date = as.Date(xx$Date, '%m/%d/%Y')

  if(!is.null(startDate)){ 
    if(startDate < min(xx$Date)){stop("Start date occurs before date in ./", basename(url),": ", min(xx$Date) )}
    xx = xx[xx$Date >= as.Date(startDate),]
    }
  
  if(!is.null(endDate)){  
    if(endDate > min(xx$Date)){stop("End date has either not occured or hasn't been recorded in ./", basename(url))}
    xx = xx[xx$Date <= as.Date(endDate),]
  }
  
  if(!is.null(rmflags)) { xx = xx[!(xx$QC_ETo %in% rmflags),]}
  if(!qc){xx = xx[, -5]}
  
  vals[[paste0('sta_', sid)]] = xx
  
  } else {
    cat(crayon::white("Data for is not recorded over this period for station: ") %+% crayon::red(sid), '\n')
  }
  }
  
  
  return(vals)
  
}

