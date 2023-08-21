## ----knitr_init, echo=FALSE, cache=FALSE---------------------------------
library(knitr)
library(rmdformats)

## Global options
options(max.print="75")
opts_chunk$set(echo=TRUE,
	             cache=TRUE,
               prompt=FALSE,
               tidy=TRUE,
               comment=NA,
               message=FALSE,
               warning=FALSE)
opts_knit$set(width=75)


## ---- calculator---------------------------------------------------------
2+2

50*(54-13)/42-3




## ----variables-----------------------------------------------------------
    
Pizza <- "Margherita" 
#a string

LuckyNumber <- 13 
#An integer

Pizze <- c("Margherita","Funghi","Capricciosa","Focaccia","Calzone") 
#A character vector
    
LuckyNumbers <- c(13,17) # a numeric vector



## ----calc with vars------------------------------------------------------

LuckyNumber + 7 

#You can also add a constant (luckynumber) 
#to a vector LuckyNmbers
LuckyNumber + LuckyNumbers

#Obviously you can also multiply or Divide

LuckyNumber * 50 + 10



## ----dataframes----------------------------------------------------------


df <- data.frame(x = seq(10,1), y = seq(1,10))

#When you assign it you need to call it to see its result normally

df

df$x # call the x variable
df$y # call the y variable


## ----index---------------------------------------------------------------

Pizze[3] #in the case of a vector we call with square brackets the third element

df[4,1] #in the case of a dataframe we call the 4th row of the first column (seq from 10 to 1)

df[,2] #Or with "nothing"plus comma we can call all the rows of the second column only

#You can also be cool and embed a vector in the indexes

df[c(1:5),] #I want only the rows from 1 to 5 of my df and of course both columns


## ---- functions----------------------------------------------------------

sum(5,4,3,1,2)

sum(df[1,])

sum(LuckyNumbers) #maybe they are even luckier?

mean(df$x)
mean(df$y)  #arguably this should be the same, right?



## ---- logics-------------------------------------------------------------

mean(df$x) & mean(df$y) > 0

mean(df$x) & LuckyNumber <= 5.5

mean(df$x) | LuckyNumber == 5.5

mean(df$x) == LuckyNumber


## ---- read file----------------------------------------------------------
#If you are on windows instead of / you can use double \\ 
#or just / (copying the path and inverting their orientation)
#dataset taken from the fantastic website of Joey Stanley credits to him! (www.joeystanley.com)

menu <- read.csv("https://marco2gandolfo.github.io/rforpsychologists/menu.csv", sep = ",")


## ---- inspect your dataset-----------------------------------------------

#what is the structure of the dataset, this gives you few crucial informations about the levels of your #factors and the number of your variables

str(menu)

#view the first 6 rows (head) and the last 6 (tail)

head(menu)
tail(menu)

#if you want to see more than 6 
head(menu,10)


## ---- indexing-----------------------------------------------------------

class(menu) #this returns the type of variable menu is, is a dataframe so it has rows and columns
#I want to take the first 10 observations of the first 4 variables
menu[1:10,1:4]

#I want to take the first 10 observations of all variables excluding the first three columns -c (see negative sign)
menu[1:10, -c(1,2,3)]

#I want to take the first 30 observation of column 4 and 6. For this we need the syntax c() for #vectors

menu[1:10,c(4,6)]

#once we know what we want to select from the main dataframe we can assign it to a variable

selmenu <- menu[1:30,c(1,3,4,6)]


## ---- base filtering-----------------------------------------------------

#Hi base R, show me the first 6 lines in which the variable fat is == 0 excluding column one to 3

head(menu[menu$Fat == 0,-c(1:3)])

#show me those lines where fat is 0 and they are not beverages or coffees and teas and store them in a #variable

zerofat <- menu[menu$Fat ==  0 & menu$Category != "Beverages" & menu$Category != "Coffee & Tea",]


## ---- install packages---------------------------------------------------
#to load it
library(tidyverse)


## ----tidydataframe-------------------------------------------------------

tidyme <- data.frame(Subj = rep(1:20, each = 250), condition = c(rep("Cong",each = 125), rep("Incong", each = 125)), rt = rep(rnorm(250), each = 20 ))

str(tidyme)
summary(tidyme)

#This is an example of how a tidy dataframe would look
knitr::kable(head(tidyme, 10))


## ---- my first plot------------------------------------------------------

head(menu) 

##Let's say I want to have a look at the linear relationship (I guess!) between calories and ##fat

calories_vs_fat <- ggplot(menu, aes(Calories,Fat)) + geom_point() #super basic scatterplot

#but to see it you have to call it
calories_vs_fat

#now let's play a little bit to add elements(regression line for instance).Do it one at a time

caloriesPretty <- calories_vs_fat + #call the previous plot we did and start adding stuff
                  geom_smooth(method = lm, se = TRUE) + # add line
                  ggtitle("The higher the calories the more the fat") + #add a title
                  theme_classic(base_size = 18) + #add a nicer theme
                  coord_cartesian(ylim=c(0,60)) + #let me see only values from 0 to 60 on y
                  coord_cartesian(xlim = c(0,1200)) + #let me see only values until 1200 kcal
                  theme(legend.title = element_blank())  #remove legend title
caloriesPretty  
                
caloriesPretty + aes(color = Category) #a bit crowded, add a color to data point per category

#now let's check the pearson's R with the cor function. This takes argument x(Calories), #y(Fat) and method = "pearson" (in this case)

cor(menu$Calories, menu$Fat, method = "pearson") #return only the R value! pretty high!

cor.test(menu$Calories, menu$Fat) #return pearson's R and significance of correlation


## ---- more graphs--------------------------------------------------------

#boxplot
ggplot(menu, aes(Category,Calories)) + geom_boxplot() +
                theme_classic(base_size = 12, base_family = "Times")
#histogram
ggplot(menu, aes(Calories)) + geom_histogram()

#line plot, not sure this is super appropriate but to have an idea of the graph type.
ggplot(menu, aes(Fat, Calories, color = Category  )) + 
              geom_line() +
              coord_cartesian(xlim=c(0,30))
              



## ----tidyverse basic-----------------------------------------------------

data <- read.csv("https://marco2gandolfo.github.io/rforpsychologists/randomdata.csv", sep = ",", header = TRUE)

#quick inspection to check if things are right

head(data, 10)
glimpse(data) #dplyr function to check structure similar to str()

#Check with xtabs how many trials by subject by site participants went through
#Ideally this is all matched

head(xtabs(~data$SubjID + data$Site))


## ----basicstuff----------------------------------------------------------

dataclean <- data %>% 
             select(-X) %>%  #unselect the column X mind about the - sign before
             rename(Experiment = Task) %>% #rename as Experiment the variable Task
             filter(!SubjID %in% c("P19","P01","p58","p63"))
            


## ----averaging-----------------------------------------------------------

AveMat <- dataclean %>% 
          group_by(SubjID, Experiment, Site, Congruency) %>%  #conditions to average for..
          summarise(meanRT = mean(RT[Acc==1]), meanAcc = mean(Acc)) %>% #apply function to ave
          mutate(Efficiency = meanRT/meanAcc)



## ---- load for anova-----------------------------------------------------

library(ez)
library(psychReport)


## ----Model on Efficiency, warning = FALSE--------------------------------

#store my anova into a variable that I call EFF_Model
EFF_Model <- ezANOVA(AveMat, dv =.(Efficiency), wid = .(SubjID), within = .(Site,Congruency), between = .(Experiment), return_aov = TRUE, detailed = TRUE)

#use aovetable function to make a nice table stored in EFF_Modelpretty variable
EFF_Modelpretty <- aovTable(EFF_Model, numDigits = 4, dispAovTable = TRUE)


#ezStats to show the means and sd of each condition
ezStats(AveMat, dv =.(Efficiency), wid = .(SubjID), within = .(Site,Congruency), between = .(Experiment))



## ---- barplot------------------------------------------------------------

Effbar  <- ggplot(AveMat, aes(Site, Efficiency, fill = Congruency )) +
           stat_summary(geom = "bar", fun.y = mean, position = "dodge", color = "black") + 
           stat_summary(geom = "errorbar", fun.data = mean_se, position = position_dodge(.9),width = 0.2) + 
           labs(y = "Efficiency ms/Acc", x= "Stimulation site")
Effbar

## ----prettiergraph-------------------------------------------------------

Effbar + facet_grid(~Experiment) + 
        theme_classic(base_size = 18, base_family = "Times") +
        scale_fill_grey() +
        coord_cartesian(ylim = c(1250,2000))


## ---- t test of subset of data-------------------------------------------

#ttest on efficiency as a function of congruency effect in the ffa site in the face experiment

Effttest <- t.test(Efficiency ~ Congruency, data= AveMat, paired = TRUE, subset = Site =="ffa" & Experiment == "face")
#Call it
Effttest
#make it prettier with the tidy function of the package broom
library(broom)
tidy(Effttest)

#ttest of congruency as afunction of congruency only in the object experiment
#note that here I used the "subset" argument to filter the data 

Effttest <- t.test(Efficiency ~ Congruency, data= AveMat, paired = TRUE, subset = Experiment == "object")



## ---- long to wide-------------------------------------------------------

wide_eff <- AveMat %>% #take the averaged matrix
            select(-meanRT, -meanAcc) %>% #remove for now the meanrt and mean Acc
            unite(Condition,  Site, Congruency) %>% #unite all the within factors in a column called "condition"
            spread(Condition, Efficiency)

head(wide_eff, 10)  #check if it looks right

write.csv(wide_eff, "~/OneDrive/RCourse_Made_by_Me/rforpsychologists/wide_eff.csv")



## ----gather--------------------------------------------------------------

long_eff <- wide_eff %>% 
            gather(condition, Efficiency, -SubjID, -Experiment) %>% 
            separate(condition, c("Site", "Congruency"), sep = "_")

head(long_eff)


