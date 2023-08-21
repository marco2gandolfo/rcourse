# Welcome to my R resources repository!

Several of my functions that have been useful to my research are available in this repository.

If you use any function from this course please refer to this DOI for acknowledgement or citation
<a href="https://zenodo.org/badge/latestdoi/365271848"><img src="https://zenodo.org/badge/365271848.svg" alt="DOI"></a>

Additionally, this repository contains also two R tutorials:

1. A very very basic introduction to the programming language of R <br> <link> https://marco2gandolfo.github.io/rcourse/ultrabasictutorial.html </link>

2. A tutorial more oriented to data analysis for a Psychological experiment, though still for beginners <link> https://marco2gandolfo.github.io/rcourse/My_First_R_Stuff_Tutorial.html </link>


The functions contained in the repository are easy to download or to copypaste or to even source in R using the source function.
e.g. <code>devtools::source_url("https://github.com/marco2gandolfo/rcourse/blob/main/FUNCTION_NAME.R?raw=TRUE") </code>

The functions contained here are:

1. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/Out_Classifier.R> Out_Classifier.R </a>: Detect outliers X SDs above or below the group mean across conditions
2. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/SDT_Classifier.R> SDT_Classifier.R </a>: Assign whether a trial was a FA - Hit - Miss - Correct rejection based on participants' response and target present/absent
3. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/mylinebarplot_function.R> mylinebarplot_function.R </a> Create a cool sexy barplot with lines and dots related to individual data points.
4. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/auroc2R.R> Auroc2R.R </a>: Calculate the area under the curve for metacognitive sensitivity. This is a porting of the matlab function related to <a href = https://www.frontiersin.org/articles/10.3389/fnhum.2014.00443/full> this paper </a> from Fleming and Lau, so credits to them!
5. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/flip_images.R> flip_images.R </a>: Flip all the images contained in a folder and export them.
6. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/gridandscramble.R> gridandscramble.R </a>: add a x by y grid to an image and scramble it.
7. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/resize_and_export.R> resize_and_export.R </a>: Resize a group of images to a desired size and export them in a folder.
8. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/resizecanvas.R> resizecanvas.R </a>: Add image to canvas of desired size without altering ratio (basically we change the size of the background of an image!)
9. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/shiftobj.R> shiftobj.R </a>: Change position of an object in an image without flipping.
10. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/shrink_images.R> shrink_images.R </a>: Reduce size of a group of images and export them all in a folder.
11. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/zoom_in_image.R> zoom_in_image.R </a>: Create a zoomed in version of an image using resizing without resampling - this will look as if the image has been zoomed in with a camera - useful for testing boundary extension effects.
12. <a href=https://github.com/marco2gandolfo/rcourse/blob/main/reverse_videos.R> reverse_videos.R </a>: Take a video - read it into R and then export a reverse played version of it.
    
