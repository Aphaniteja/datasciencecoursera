xtrain=read.table("./train/X_train.txt")##Loads Xtrain
ytrain=read.table("./train/y_train.txt")##Loads Ytrain
colnames(ytrain)=c("y")                ##renames ytrain column to y
xtest=read.table("./test/X_test.txt") ##Loads Xtest
ytest=read.table("./test/y_test.txt") ## Loads Ytest
colnames(ytest)=c("y")             ##renames ytest column to y

##Following lines reaname the y values to activities
ytest[ytest==1]<-"LAYING"
ytest[ytest==3]<-"STANDING"
ytest[ytest==2]<-"SITTING"
ytest[ytest==4]<-"WALKING"
ytest[ytest==5]<-"WALKING_DOWNSTAIRS"
ytest[ytest==6]<-"WALKING_UPSTAIRS"
ytest=as.factor(ytest[,1]) #converts y values to factors
ytrain[ytrain==1]<-"LAYING"
ytrain[ytrain==3]<-"STANDING"
ytrain[ytrain==2]<-"SITTING"
ytrain[ytrain==4]<-"WALKING"
ytrain[ytrain==5]<-"WALKING_DOWNSTAIRS"
ytrain[ytrain==6]<-"WALKING_UPSTAIRS"
ytrain=as.factor(ytrain[,1])
ytest=as.factor(ytest[,1]) #converts y values to factors
test=cbind(xtest,ytest) ##combines xtest and ytest values
train=cbind(xtrain,ytrain)##combines xtrain and ytrain values
subtrain=read.table("./train/subject_train.txt") #loads training subjects 
subtest=read.table("./test/subject_test.txt") # loads testing subjects
## appends subject values to train and test
test$subject=subtest 
train$subject=subtrain
## renames test and train activity and subject columns
colnames(train[,563])="sub"
colnames(test[,563])="sub"
colnames(test)[562]="activity"
colnames(train)[562]="activity"
## finally test and train set combined

dataset1=rbind(train,test,row.names=FALSE)

feature=read.table("features.txt")## loads features
nm=(feature[,2]) ##extracts names
dataset2=dataset1 ## creates a duplicate so as to hold different versions
colnames(dataset2)<-nm ## renames the columns of dataset based on feature names
##renaming the activity and subject columns
colnames(dataset2)[562]<-"activity" 
colnames(dataset2)[563]<-"subject"
## extracting the mean and sd values and combining them to a data frame
df<-dataset2[,grep("mean()",colnames(dataset2))]
df2<-dataset2[,grep("std()",colnames(dataset2))]
df<-cbind(df,df2)
## adding subject and activity columns to new data frame
df$Activity=dataset2$activity
df$subject=dataset2$subject
## removing a row which contained row names
df<-df[1:10299,]
##re arranging the order of columns to put subject and activity in front
df2<-df[,c(81,80,1:79)]

##loading reshape2 package to use melt and dcast commands so as to  create a tidy data set 
##which contains the data ordered based on subject and activity
library(reshape2)
meltdf<-melt(df2,id=c(1,2),measure.vars=c(3:81))
Subdata<-dcast(meltdf,subject+Activity~variable,mean)
write.table(Subdata,"tidydata.txt")



