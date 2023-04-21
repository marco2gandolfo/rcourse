zoom_in_image <- function(im, px_from = 10, px_to = 13, interval = 0.5, nimgs = 1) {
  ## this function zooms in one or a list of images through resizing without resampling.
  ## it is ready for zooming in images by several percentages of a predefined interval. 
  ## px from and px to refer to the percentage of resizing per side of the image - so 10-13 roughly correspond to the double of resizing in 
  ## the total area of the image.
  ## nimgs - if you have more than one image insert the total no of images you want to resize, for example by inserting nimgs = length(imlist)
  ## the function will also return a dataframe in the second element of the list with all the details of the resized images :)
  
  if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
  if (!require('imager')) install.packages('imager'); library('imager')
  
  #define function that takes the size of an image and calculate how big would be if reduced by the desired percentage
  percpx <- function(perc, im){
    #this function calculates the size of an image if it was reduced by x percentage of an image prints it, and stores it into a vector
    
    imsize <- dim(im)
    imperc_X <- (imsize[1]*perc)/100
    imperc_y <- (imsize[2]*perc)/100
    
    newx <- imsize[1] - imperc_X
    newy <- imsize[2] - imperc_y
    
    new_area <- newx*newy
    diffarea <- 100 - ((newx*newy)*100)/(imsize[1]*imsize[2]) # calculate how smaller the new image is in percentage
    # this indicates the area
    
    print(paste0("the ", perc,"% of this image on each side is ", newx, " x ", newy ))
    print(paste0("the image is then ", diffarea, "% smaller")) ## really need to think more about the maths
    
    return(newsize <- c(round(newx), round(newy), round(diffarea)))
  }
  
  
  percentages <- seq(px_from, px_to, interval) ## 
  
  #sample32percentages as many images x condition so that we randomly apply the zoom but keep it the same for every image.
  randperc <- sample(percentages, nimgs, replace = TRUE)
  
  
  if (nimgs > 1) {
    
    if (is.null(names(im))) {
      imgnames <- paste0("close_", nimgs) 
    } else {
      imgnames <- names(im)
    }
    
    print(imgnames)
    close_imglist <- list()
    
    ## data frame where you will be storing the percentages of resizing
    mod_image_data <- data.frame(imgname = NA, size_width = NA, size_height = NA, pcresize = NA)
    
    for (img in seq_along(im)) {
      
      mod_image <- data.frame(imgname = NA, size_width = NA, size_height = NA, pcresize = NA)
    
      #compute some img sizes corresponding to a certain scaling percentage
      resizecoor <- percpx(randperc[img], im[[img]])
      
      # resize without resampling
      close_imglist[[img]] <- resize(im[[img]], size_x = resizecoor[1], size_y= resizecoor[2], interpolation_type = 0, centering_x = 0.5, centering_y = 0.5)
      # back to previous size
      close_imglist[[img]] <- resize(close_imglist[[img]], size_x = dim(im[[img]])[1], size_y= dim(im[[img]])[2], interpolation_type = 6, centering_x = 0.5, centering_y = 0.5)
      
      
      #assign variables to dataframe with img infos
      mod_image$imgname <- imgnames[img]
      mod_image$size_width <- resizecoor[1] # store the width of the image that zooms in
      mod_image$size_height <- resizecoor[2] # stores the height of the image that zooms in
      mod_image$pcresize <- resizecoor[3] # stores the reduction of the area 
      
      print(paste0(mod_image$imgname, " Done"))
      mod_image_data <- rbind(mod_image, mod_image_data)
    }
    
    names(close_imglist) <- paste0("close_", imgnames)
    return(list(close_imglist, mod_image_data))
    
  } else {
    
    mod_image <- data.frame(imgname = NA, size_width = NA, size_height = NA, pcresize = NA)
    
    imgname <- paste0("close_", nimgs)
    #compute some img sizes corresponding to a certain scaling percentage
    resizecoor <- percpx(randperc, im)
    
    # resize without resampling
    close_img <- resize(im, size_x = resizecoor[1], size_y= resizecoor[2], interpolation_type = 0, centering_x = 0.5, centering_y = 0.5)
    # back to previous size
    close_img <- resize(close_img, size_x = dim(im)[1], size_y= dim(im)[2], interpolation_type = 6, centering_x = 0.5, centering_y = 0.5)
    
    #assign variables to dataframe with img infos
    mod_image$imgname <- imgname
    mod_image$size_width <- resizecoor[1] # store the width of the image that zooms in
    mod_image$size_height <- resizecoor[2] # stores the height of the image that zooms in
    mod_image$pcresize <- resizecoor[3] # store the percentage
  
  }
    
  return(list(close_img, mod_image))
  
}