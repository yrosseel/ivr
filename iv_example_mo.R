Data <- read.csv("mo.csv", header = FALSE, sep = ",")
names(Data) <- c("share", "perform", "mo", "innov")

source("ivr.R")
fit.iv <- ivr(y = Data[,"share"],
              X = Data[,c("perform")],
              Z = Data[,c("mo", "innov")],
              NAMES = c("share", "perform", "mo", "innov"),
              fixed.x = TRUE,
              meanstructure = TRUE)

# print estimates + NT/ADF standard errors
EST <- fit.iv$theta
SE.NT  <- sqrt(diag(fit.iv$VCOV.NT))
SE.ADF <- sqrt(diag(fit.iv$VCOV.ADF))
print( round( cbind(EST, SE.NT, SE.ADF), 4) )

# tests
print( fit.iv$T.Sargan )
print( fit.iv$T.Browne.NT )
print( fit.iv$T.Hansen )
print( fit.iv$T.Browne.ADF )

