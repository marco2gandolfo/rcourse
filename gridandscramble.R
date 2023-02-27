gridandscramble <- function(importpath, exportpath, gridsize = 10) { 
## this function will take an object image on a white background, grayscale it, scramble it
## after, it will add a grid of a desired block size (default is 10) to the object as often used in fMRI paradigms
## to localise LOC.

if (!require('imager')) install.packages('imager'); library('imager')
if (!require('purrr')) install.packages('purrr'); library('purrr')
if (!require('magick')) install.packages('magick'); library('magick')

## define scrambling function - from imager package creator barthelme' - with the possibility to edit the blocksize
scramble <- function(im,axis="x", blocksize = -1)
{
  imsplit(im,axis, nb = blocksize) %>% { .[sample(length(.))] } %>% imappend(axis) 
}

# read the image names
imfiles <- list.files(importpath, pattern = ".jpg|.png", full.names = TRUE, recursive = FALSE)

# print names
print(imfiles)


# read the images
theobjs <- map(imfiles, image_read)
print("IMAGE LIST IS LOADED")

# grayscale images
grims <- map(theobjs, ~image_convert(., colorspace = "gray"))

# convert in cimg for scrambling
grimsimgr <- map(grims, magick2cimg)

# scramble
scrlist <- map(grimsimgr, ~scramble(., blocksize = gridsize) %>% 
                 scramble(axis = "y", blocksize = gridsize) %>% 
                 scramble(blocksize = gridsize) %>% 
                 scramble(axis = "y", blocksize = gridsize))

# convert back to magick format
scrimgs <- map(scrlist, cimg2magick)
print("IMAGE LIST IS SCRAMBLED")

# remove the cimg list and clean ram
rm(scrlist) %>% gc()

# add borders to both lists
bdgrims <- map(grims, ~image_border(., color = "black", geometry = "1x1"))
bdscrimgs <- map(scrimgs, ~image_border(., color = "black", geometry = "1x1"))

# pick up the names
imnames <- basename(imfiles)

# make the new paths 
newnames_full <- paste0(exportpath, "/", imnames)
newnames_scr <- paste0(exportpath, "/scr_", imnames)


## add grid to the full cue images
for(img in seq_along(imnames)) {
  theimg <- image_draw(bdgrims[[img]])
  grid(nx = gridsize, ny = gridsize, lty = "solid", col = "black")
  dev.off()
  image_write(theimg, newnames_full[[img]],quality = 100)
}
print("IMAGE GRID ADDED TO FULL IMGS")

## add grid to the scrambled images
for(img in seq_along(imnames)) {
  theimg <- image_draw(bdscrimgs[[img]])
  grid(nx = gridsize, ny = gridsize, lty = "solid", col = "black")
  dev.off()
  image_write(theimg, newnames_scr[[img]],quality = 100)
}
print("IMAGE GRID ADDED TO SCRAMBLED IMGS")

}


