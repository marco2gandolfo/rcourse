flip_images <- function(importpath, exportpath, imgformat = "jpg"){
  ## this function will flip all the images in an importpath, and export them in a 
  ## exportpath. You also include the imgformat. It defaults to JPEG but could also insert png.
  
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
  
  ## flip the images
  fl_imlist <- map(imlist, image_flop)
  print("IMAGE LIST IS FLIPPED, prepare to write imgs")
  
  ## remove the list of the nonflipped imgs
  rm(imlist)
  
  
  ## export all the images to the destinationpath
  for(img in seq_along(fl_imlist)){
    image_write(fl_imlist[[img]], paste0(exportpath, "/", thenames[img]), quality = 100, format = imgformat)
  }
  
  rm(fl_imlist)
}