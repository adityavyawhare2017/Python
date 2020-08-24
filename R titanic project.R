setwd("C:/Users/Hp/Downloads/kaggle")

titanic.train <- read.csv(file= "train.csv",stringsAsFactors = FALSE,header = TRUE)
titanic.test <- read.csv(file= "test.csv",stringsAsFactors = FALSE,header = TRUE)


titanic.train$istrainset <- TRUE
titanic.test$istrainset <- FALSE

titanic.test$Survived <- NA

titanic.full <- rbind(titanic.train,titanic.test)

titanic.full[titanic.full$Embarked=='',"Embarked"] <- 'S'

#CLEANING MISSING VALUES OF AGE
age.median <- median(titanic.full$Age, na.rm = TRUE)
titanic.full[is.na(titanic.full$Age), "Age"] <- age.median

#CLEANING MISSING VALUE OF FARE
Fare.median <- median(titanic.full$Fare, na.rm = TRUE)
titanic.full[is.na(titanic.full$Fare), "Fare"] <- Fare.median


#CATOGARIAL CASTING
titanic.full$Pclass <- as.factor(titanic.full$Pclass)
titanic.full$Sex <- as.factor(titanic.full$Sex)
titanic.full$Embarked <- as.factor(titanic.full$Embarked)

#SPLIT DATA SET INTO TEST AND TRAIN
titanic.train<-titanic.full[titanic.full$istrainset==TRUE,]
titanic.test<-titanic.full[titanic.full$istrainset==FALSE,]

#Building Model on random forest

titanic.train$Survived <- as.factor(titanic.train$Survived)


survived.equation <- "Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
survived.formula <- as.formula(survived.equation)
install.packages("randomForest")

library(randomForest)

titanic.model <- randomForest(formula = survived.formula, data = titanic.train, ntree = 500, mtry = 3, nodesize = 0.01*nrow(titanic.train))
                              
features.equation <- "Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
Survived <- predict(titanic.model, newdata = titanic.test)                              
                              
PassengerId <- titanic.test$PassengerId
output.df <- as.data.frame(PassengerId)
output.df$Survived <- Survived

write.csv(output.df,file = "Kaggle_submission.csv", row.names = FALSE)
