getCIMIS_annual = function(year, stationID, qc = FALSE, units = 'SI', rmflags = NULL){
  
  `%+%` = crayon::`%+%`

  ylist = list()
  flist = list()
  sid.list = list()

  if(units == 'metric'){units = "Metric"} else {units = NULL}
  
  for( i in seq_along(year)){
    
  zip <- tempfile(fileext = ".zip")
  dir = tempdir()
  
  valid = list.files(dir, pattern = paste0(year[i], 'daily'), full.names = T)
  
  if(!all(length(valid) > 0,  !file.exists(valid))){
    cat(crayon::yellow("Dowloading data: ") %+% crayon::white(year[i], "\n"))
    download.file(paste0('ftp://ftpcimis.water.ca.gov//pub2/annual', units, '/dailyStns', year[i], '.zip'), zip, quiet = TRUE)
    unzip(zip, exdir = dir)
  }

  files = list.files(dir, pattern = '.csv', full.names = T)
  
  good.stations = unique(regmatches(files, regexpr("daily\\s*\\K.*?(?=\\s*.csv)", files, perl=TRUE)))
  
  for(j in seq_along(stationID)){
    
    if(is.numeric(stationID[j])){ sid = sprintf("%03d", stationID[j])} else{ sid = stationID[j]}
    
    if(sid %in% good.stations){
    
        sid.list[[j]] = sid
      
        f1 = files[grepl(paste0(year[i], 'daily', sid), files)]
        
      if(length(f1) > 0){
        
        d = read.csv(f1, header=FALSE, na.strings=c('       --', "--", "*", '  #######', '#######', '#####'), stringsAsFactors = FALSE)
        
        if(year[i] >= 2014) { 
          colnames(d) <- cimis.daily.post2014$Field
        } else { 
          colnames(d) <- cimis.daily.pre2014$Field
          d = d[ ,cimis.daily.post2014$Field]
        }

        d$Date <- as.Date(as.Date(d$Date,format= '%m/%d/%Y'), format ="%Y-%m-%d")
        d$year =  as.numeric(substring(d$Date,1,4))
        d$month = as.numeric(substring(d$Date,6,7))
        d$day =   as.numeric(substring(d$Date,9,10))
        
        if(!qc){ d  = d[ , !grepl("QC", colnames(d)) ] } # rm quality control flags
        
        if(!is.null(rmflags)) { d = d[!(d %in% rmflags),]}
        
        ylist[[paste0('sta_', sid, "_", year[i])]] = d
        cat(crayon::green("\tData downloaded:") %+% crayon::white(" station", sid, '\n'))
        
    } else {
      cat(crayon::red("\tNo data available:") %+% crayon::white(" station", sid, '\n'))}
    } else {
      cat(crayon::red("\tNo data available:") %+% crayon::white(" station", sid, '\n'))}
  }
  
  file.remove(files, recursive = TRUE)

  }
  
  ids = unlist(sid.list)
  
  for(z in seq_along(ids)){
    tmp.list = data.table::rbindlist(ylist[grepl(ids[z], names(ylist))])
    
    if(length(tmp.list) > 0){
      flist[[paste0('sta_', ids[z])]] = tmp.list
    }
  }

  return(flist)
}


