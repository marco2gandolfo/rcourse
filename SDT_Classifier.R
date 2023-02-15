SDT_Classifier <- function(x, y) {
  # Function where x is Target (1 present 0 absent) and y is accuracy (1 correct 0 incorrect trial)
  # this will return a vector coding whether a response was a hit - cr - miss - or false alarm
  performance <-rep(NA, length(x))    #define empty performance vector
  performance[x ==1 & y == 1] <- "Hit"
  performance[x==0 & y == 1] <- "Cr"
  performance[x== 1 & y == 0 ] <- "Miss"
  performance[x== 0 & y == 0] <- "FA"
  return(performance)
}
