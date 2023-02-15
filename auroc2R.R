auroc2R <- function(correct, conf, Nratings) {
  # function auroc2 = type2roc(correct, conf, Nratings)
  #
  # Calculate area under type 2 ROC
  #
  # correct - vector of 1 x ntrials, 0 for error, 1 for correct
  # conf - vector of 1 x ntrials of confidence ratings taking values 1:Nratings
  # Nratings - how many confidence levels available
  
  i <- Nratings+1
  H2 <- c()
  FA2 <- c()
  for (c in 1:Nratings){
    H2[i-1] <- length(which(conf == c & correct == 1)) + 0.5
    FA2[i-1] <- length(which(conf == c & correct == 0)) + 0.5
    i <- i-1
  }
  
  H2 <- H2/sum(H2);
  FA2 <- FA2/sum(FA2)
  cum_H2 <- c(0, cumsum(H2))
  cum_FA2 <- c(0, cumsum(FA2))
  
  i <- 1
  k <- c()
  for(c in 1:Nratings){
    k[i] <- (cum_H2[c+1] - cum_FA2[c])^2 - (cum_H2[c] - cum_FA2[c+1])^2
    i <- i+1
  }
  auroc2 <- 0.5 + 0.25*sum(k)
  
  return(auroc2)
  
}