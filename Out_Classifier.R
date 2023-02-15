
Out_Classifier <- function(x,y = 2.5) {
  # x is a vector of subject's performance 
  # y is the no. of SDs above/below the group mean - default to 2.5
  performance <-rep(NA, length(x))  #Performance empty vector
  
  for (i in  1:length(x)) {
    if(x[i] > mean(x)+(sd(x)*y)){
      performance[i] <- "slow"
    }
    else if (x[i] < mean(x)-(sd(x)*y)){
      performance[i] <- "Inaccurate/fast"
    }
    else {performance[i] <- "OK"
    }
  }
  print(performance)
}
