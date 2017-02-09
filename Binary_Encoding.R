
library(R.utils)
setwd("D:/Text_Analytics")

#import the file with stringsAsFactors=FALSE
source<-read.csv('Binary_Encoding_Test.csv', head = TRUE,na.strings=c("") ,sep=",",stringsAsFactors=FALSE)


#change all NA values to "N/A"
source[is.na(source)]<-"N/A"

#factorize categorical variables
source$RHS_BOUNDARY<-as.factor(source$RHS_BOUNDARY)


#change the categorical values into binary
a<-c(intToBin(source$RHS_BOUNDARY))
b<-nchar(a[1])
c<-paste0("RHS_BOUNDARY",1:b)


d<-(data.frame(t(matrix(as.numeric(unlist(strsplit(a,""))),nrow = b,
                        dimnames=list(c)))))


to_merge<-cbind(source[1],d)
