##Introduction to R##
#R is case sensitive
#R and Python are some of the most commonly used coding languages
#I typically use SAS and R 
#R is free

##Setting it up on your laptop##
#First, download R: https://www.r-project.org/
#Next (optional), download R Studio: https://www.rstudio.com/products/rstudio/download/

##The basics##
#The # symbol allows you to make comments throughout your script
#Scripts vs. the console...NEVER type code directly into the console
#command+enter is a shortcut for highlighting and clicking "run"
#R is like a calculator
1+2
sqrt(36)
2^2
pi
1/2

#Objects
hello <- c(1:9)
madeline <- c(2, 2, 2)
hello + madeline
hello + 2

#Base R functions
mean(hello)
length(hello)
max(hello)
sum(hello)

#The next two lines of code can help you determine the appropriate arguments to include for each function
?mean
help(mean)
#Sometimes you may want to use a function that requires a special download called a package
install.packages("psych")
library("psych")

#Strings
a <- "hello"
b <- c("hello", "madeline")
typeof(a)
typeof(hello)

#Vectors
a <- c(1, 2, 3, 4, 5, 6)
class(a)
c(1:6)
b <- c("a", "b", "c")
class(b)

#Random samples
sample(1:500, 10, replace = F)

#Matrix notation
hello[3] 
hello[9]

#Logical operators
logic1 = a >3
logic1
logic2 = (a > 2) & (a <5)
logic2
logic3 = a!=2
logic3
class(logic1)

##Reading in data##
#csv files
getwd()
setwd("/Users/madelinecraft/Desktop")
getwd()
mydata1<-read.csv("edu_data.csv")
head(mydata1)
tail(mydata1)

#txt files
bmiData = read.table('lab2data.txt', header = TRUE)
head(bmiData)

#You can also read in excel files, sas files, r files, etc.

#Let's practice setting working directories...
setwd("/Users/madelinecraft/Downloads")
mydata3<-read.csv("edu_data.csv")
head(mydata3)

setwd("/Users/madelinecraft/Desktop/103A")
mydata2<-read.csv("edu_data.csv")
head(mydata2)

##Summarizing the data and calculating descriptive statistics##
#How are descriptive statistics different from inferential statistics?
#Descriptive statistics are calculated to describe a current sample whereas inferential statistics use sample characteristics to infer things about a population. 
mydata1$meals
mydata1[,4]
summary(mydata1$meals)
levels(mydata1$some_col)
mydata1$some_col<-as.factor(mydata1$some_col)
dim(mydata1)
range(mydata1$api00)
range(mydata1$meals)

#Mean: the average, extremely sensitive to outliers
mean(mydata1$api00,na.rm=TRUE)
mean(mydata1$meals,na.rm=TRUE)

#Median: the middle value in a list of numbers when all the numbers have been ordered
median(mydata1$api00,na.rm=TRUE)
median(mydata1$meals,na.rm=TRUE)

#Mode: most frequently occuring number
#there isn't a built in function, so you have to create your own

#Standard deviation: quantifies the extent that numbers in the sample deviate from the mean 
sd(mydata1$api00,na.rm=TRUE)
sd(mydata1$meals,na.rm=TRUE)

#Variance: the standard deviation squared
var(mydata1$api00,na.rm=TRUE)
var(mydata1$meals,na.rm=TRUE)

#Sometimes you might want to calculate the mean and standard deviation by group
install.packages('psych')
library('psych')
describeBy(bmiData$weight_lbs, bmiData$biosex)

##Types of variables##
#Nominal: Levels of nominal variables are either qualitative or numbers assigned to represent categories.
#Ordinal: Levels represent classifications of rank. The difference between 1st and 2nd doesn't not need to be the same as the difference between 2nd and 3rd.
#Interval: The differences between values are meaningful but zero cannot be meaningfully interpretted. 
#Ratio: The same as interval except zero exists and can be meaningfully interpretted.

