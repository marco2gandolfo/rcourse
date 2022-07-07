reverse_videos <- function(importpath, exportpath, thefps = 30){
  ### this function will generate a reverse played version of a video
  ### import path is the folder where the original videos are found; 
  ### export path is where you want to export the videos.
  ### if not declared the thefps will default at 30.
  
  if (!require('magick')) install.packages('magick'); library('magick') ## list videos in import folder
  vpaths <- list.files(importpath, pattern = "mp4", full.names = TRUE)
  ## extract the names
  vnames <- basename(vpaths)
  
  for(v in seq_along(vpaths)){
    gc()  ## clean up the ram before starting a new video
    vidz <- image_read_video(vpaths[v], fps = thefps) ## read up the video
    image_write_video(rev(vidz), paste0(exportpath, "/", vnames[v]), framerate = thefps) ### write the rev video
    rm(vidz) ## remove the video to free up space
  }
}