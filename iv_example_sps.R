Data <- read.csv("college_labels.csv", head = TRUE, sep = ",")

source("ivr.R")
fit.iv <- ivr(y = Data[, "sps"],
              X = Data[, c("rps", "ics", "as")],
              Z = Data[, c("age", "female", "ppo", "npo")],
              NAMES = c("sps", "rps", "ics", "as", "age",
                        "female", "ppo", "npo"),
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
