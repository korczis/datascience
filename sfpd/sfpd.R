require(bit64)
require(lubridate)
require(data.table)

sfpdDownload <- function(url = "https://data.sfgov.org/api/views/tmnf-yvry/rows.csv?accessType=DOWNLOAD", file = "sfpd.csv") {
  download.file(url, destfile = file)
}

sfpdLoadRaw <- function(file = "sfpd.csv") {
  fread(file)  
}

sfpdLoad <- function(file = "sfpd.csv") {
  data <- sfpdLoadRaw(file)

  names(data) <- sapply(names(data), tolower)
  
  data %>% mutate(
    day = mday(mdy(date)),
    wday = wday(mdy(date)),
    month = month(mdy(date)), 
    year = year(mdy(date))
  )
}

sfpdStats <- function(data) {
  # Generate stats
  list(
    # By year
    by.year = data %>% 
      group_by(year) %>% 
      summarize(count = n(), ratio = n() / nrow(data)) %>% 
      arrange(-ratio),
    
    # By month
    by.month = data %>% 
      group_by(month) %>% 
      summarize(count = n(), ratio = n() / nrow(data)) %>% 
      arrange(-ratio),
    
    # By day
    by.day = data %>% 
      group_by(day) %>%
      summarize(count = n(), ratio = n() / nrow(data)) %>% 
      arrange(-ratio),
    
    # By pddistrict
    by.district = data %>% 
      group_by(pddistrict) %>%
      summarize(count = n(), ratio = n() / nrow(data)) %>% 
      arrange(-ratio),
  
    # By category
    by.category = data %>% 
      group_by(category) %>%
      summarize(count = n(), ratio = n() / nrow(data)) %>% 
      arrange(-ratio),
    
    # By resolution
    by.category = data %>% 
      group_by(resolution) %>%
      summarize(count = n(), ratio = n() / nrow(data)) %>% 
      arrange(-ratio)
  )
}
