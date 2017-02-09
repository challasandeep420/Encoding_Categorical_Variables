#rm(list=ls())
setwd('D:/Text_Analytics')


#import the file with stringsAsFactors=FALSE
source<-read.csv('Binary_Encoding_Test.csv',header=TRUE,na.strings=c("") ,sep=",",stringsAsFactors=FALSE)


#change all NA values to "N/A"
source[is.na(source)]<-"N/A"


#factorize categorical variables
source$RHS_BOUNDARY<-as.factor(source$RHS_BOUNDARY)


#count the number of levels
n<-nlevels(source$RHS_BOUNDARY)-1
unique_levels<-unique(source$RHS_BOUNDARY)

#create a backward difference table
r<-n+1
c<-r-1
fd_table<-matrix(data=NA, nrow=r, ncol=c)


for(j in 1:c){
  for(i in 1:r){
    fd_table[i,j] = if(i>j){-j/r}
    else{(r-j)/r}
  }
}


#change column names of the table
col_name<-paste0("RHS_BOUNDARY",1:n)
colnames(fd_table)<-col_name


#convert the table to data frame
df1<-data.frame(fd_table)


#add the identifier required for merging 
df1$RHS_BOUNDARY<-unique_levels


#merge and drop uneccessary columns
to_merge<-merge(x = source[,c("X","RHS_BOUNDARY")], y = df1, by = "RHS_BOUNDARY", all.x = TRUE)
to_merge$RHS_BOUNDARY<-NULL

