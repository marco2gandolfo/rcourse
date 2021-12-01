shrink_images <- function(importpath, exportpath, imgformat, imgquality = 75){
  ## allstrings
  
  if (!require('magick')) install.packages('magick'); library('magick')
  if (!require('purrr')) install.packages('purrr'); library('purrr')
  
  ### get the filepaths
  filelist <- list.files(importpath, pattern = ".jpg|.png", full.names = TRUE)
  
  print(filelist);
  
  ## get the basenames of these paths
  thenames <- basename(filelist)
  
  
  ## read the images
  imlist <- map(filelist, image_read)
  print("IMAGE LIST IS LOADED")
  
  ## scale the images
  sh_imlist <- map(imlist, ~image_scale(.,"80%"))
  print("IMAGE LIST IS rescaled, prepare to write imgs")
  
  ## remove the list of the nonflipped imgs
  rm(imlist)
  
  
  ## export all the images to the destinationpath
  for(img in seq_along(sh_imlist)){
    image_write(sh_imlist[[img]], paste0(exportpath, "/", thenames[img]), quality = imgquality, format = imgformat)
  }
  
  rm(sh_imlist)
}