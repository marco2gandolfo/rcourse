shiftobj <- function(img, alphaval = 0.1, theaxis = "x", thebgcol = c(0.5,0.5,0.5)){
  ## this function will use cannyedge det. to detect a main object on a pretty flat background
  ## then create a bounding box surrounding it - chopping it off and put it in the corresponding
  ## position on the other side of the square, without flipping
  ## alphaval: is a number between 0 and 1 indicating the tolerance of the edge detector - default is low thresh (0.1)
  ## imager pick the best guessed one by it.
  ## theaxis: string is the axis on which you want to flip the object around - x or y - defaults to x
  ## thebgcolor - defualt is "gray" but can be some other color in string or 
  ## on a 3 0 to 1 RGB vector e.g. c(0.5, 0.5, 0.5) == "gray"
  
  if (!require('imager')) install.packages('imager'); library('imager')
  if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
  
  ### get the filepaths
  # img is an imager object - loaded with load.image
  plot(img)
  # apply threshold and a bit of blur
  thimg <- cannyEdges(grayscale(img), alpha = alphaval) 
  #plot(thimg)
  
  # clean it up a bit
  thimg2 <- imager::fill(thimg, 30) %>% imager::clean(3) 
  rm(thimg) # remove the previous img
  
  # try to plot the final threshold to check how it looks 
  # comment this for performance
  #plot(thimg2)
  
  # identify the bounding box of the thresholded object
  thebox <- bbox(thimg2)
  #plot(mirror(thebox, axis = theaxis))
  
  ## crop the box from the actual coloured img
  theobj <- crop.bbox(img, thimg2)
  #plot(theobj)
  ## find the coordinates of the top left corner of the box of the thresholded
  ## img - not that the image is flipped horizontally - default axis is x
  sqcord <- as.data.frame(as.cimg(mirror(thebox, axis = theaxis))) %>% 
              filter(value > 0) %>% 
              dplyr::group_by(value) %>% 
              dplyr::summarise(mx=min(x),my=min(y))
  
  ## fill back the image with the flipped square with the gray color (default)
  ## can also be a 3d vector with 3 values between 0 and 1 RGB
  grfill <- imfill(dim = dim(mirror(as.cimg(thebox), axis = theaxis)), val = thebgcol)
  
  
  flimg <- imdraw(grfill, theobj, x = sqcord$mx, y = sqcord$my) 
  plot(flimg)
  
  rm(theobj)
  
  return(flimg)

}

