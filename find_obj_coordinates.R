find_obj_coordinates <- function(img, alphalevel = 0.1){
  ## this function will use cannyedge det. to detect a main object on a pretty flat background
  ## then create a bounding box surrounding it - and return happily the coordinates of its bounding box :)
  ## it assumes a .png 
  ## can change the alphalevel for canny edge detection if it looks weird
  
  if (!require('imager')) install.packages('imager'); library('imager')
  if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
  
  # if has 4 colour channels is a png then remove alpha channel
  if(dim(img)[4] == 4){
  img <- rm.alpha(img)
  } 
  
  ## check if the image is already grayscaled or has less than 3 channels otherwise grayscale it
  if(dim(img)[4] >= 3){
    imggray <- grayscale(img)
  } else { # to fix that evil image with 2 channels
    image_r <- img  # Red channel
    image_g <- img  # Green channel
    image_b <- img  # Blue channel
    alpha_channel <- array(1, dim = dim(img))
    
    # Combine the channels into an RGB image
    img <- imager::as.cimg(array(c(image_r, image_g, image_b), 
                                        dim = c(dim(img)[1],dim(img)[2], 1, 3)))
    imggray <- grayscale(img)
  }
  
  # do canny edge detection to find image extremities
  thimg <- cannyEdges(imggray, alpha = 0.1)
  # make this prettier - like a pretty clean silhouette
  thimg2 <- imager::fill(thimg,30) %>% imager::clean(3)
  rm(thimg) # remove the previous image
  
  #now draw the bounding box around this object 
  thebox <- imager::bbox(thimg2)
  
  # extract the coordinates of the white square
  sqcord <- as.data.frame(as.cimg(thebox)) %>% 
    filter(value > 0) %>% 
    dplyr::group_by(value) %>% 
    dplyr::summarise(minx=min(x),miny=min(y), maxx = max(x), maxy = max(y), width = maxx - minx, height = maxy - miny) %>% 
    dplyr::mutate(center_x = (minx + maxx)/2, center_y = (miny + maxy)/2, area = width*height)
  
  return(sqcord)
}
