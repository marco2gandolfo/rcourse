resizecanvas <- function(im, bgcolor = "white", impos = "center", resize = FALSE, sqsize = 400) {
  # the function will take an image and paste it on the center of a square (by default) or on the left/right/top/bottom. 
  # by default (if resize is false) the square is as wide as the widest side of the given image.
  # im is an image read in image magic using image_read. 
  # bg color is the color of the canvas where we are placing the image, white by default
  # impos relates to the position of the image on the canvas
  # resize if TRUE performs resizing of a given sqsize in pixels
  # sqsize size of the square in pixels - if you want it to be different from the longest side of the input image.
  
  if (!require('purrr')) install.packages('purrr'); library('purrr')
  if (!require('magick')) install.packages('magick'); library('magick')
  if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
  
  # extract image information
  iminfo <- image_info(im)
  # figure whether image is portrait or landscape
  iminfo <- iminfo %>% mutate(ratio = case_when(width > height ~ "landscape",
                                                TRUE ~ "portrait"))
  
  # adjust canvas to be as big as the largest side
  if(iminfo$ratio == "landscape") {
    horsquare = iminfo$width
    theimg <- image_composite(image_blank(width = horsquare, height = horsquare, bgcolor), image_scale(im, paste0(horsquare, "x")), gravity = impos)
  } else if (iminfo$ratio == "portrait") {
    versquare = iminfo$height
    theimg <- image_composite(image_blank(width = versquare, height = versquare, bgcolor), image_scale(im,  paste0("x",versquare)), gravity = impos)
  }
  
  if(resize == TRUE){
   thersimage <- image_resize(theimg, geometry = paste0(sqsize, "x", sqsize))
   return(thersimage)
  } else {
   return(theimg)
  }
}
