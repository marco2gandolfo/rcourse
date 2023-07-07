library(magick)
library(tidyverse)

thedirs <- dir("stimuli", full.names = FALSE)

## create directories with same name in the rs stimuli folder
for (dir in list.dirs("stimuli", full.names = FALSE)){
  dir.create(paste0("rs_stimuli/",dir))
}

for(dir in thedirs) {
  thelist <- list.files(paste0("stimuli/", dir), full.names = TRUE)
  imgs <- map(thelist, image_read)
  print(paste0("folder ", dir, " succesfully read"))
  rsimgs <- map(imgs, ~image_resize(., "500x500", filter = "Lanczos"))
  print(paste0("folder ", dir, " succesfully resized"))
  for(img in seq_along(thelist)) {
    image_write(rsimgs[[img]], paste0("rs_stimuli/",dir, "/", basename(thelist)[img]), quality = 100)
  }      
  print(paste0("folder ", dir, " succesfully exported"))
  gc()
}
