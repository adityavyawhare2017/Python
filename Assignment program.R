setwd("C:/Users/Hp/Downloads/kaggle")

train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

#spliting train into 80 % and 20%

ind <- sample(2,nrow(train),replace = TRUE,prob = c(0.8,0.2))
Tdata <- train[ind==1,]
Vdata <- train[ind==2,]


Vdata$alldied <- 0
Vdata$allsurvived <- 1
Vdata$ladiesandchild <-0

Vdata$ladiesandchild[Vdata$Sex == 'female'] <- 1
Vdata$ladiesandchild[Vdata$Age < 18 ] <- 1

Vdata$childladies35 <- 0

Vdata$childladies35[Vdata$Age < 35] <- 1
Vdata$childladies35[Vdata$Sex== 'female'] <- 1

write.csv(Vdata, file = "Assignement.csv",row.names = FALSE)

