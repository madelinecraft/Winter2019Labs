###########################################################
#What is the difference between a POINT ESTIMATE and an INTERVAL ESTIMATE? 
## POINT ESTIMATE

setwd("/Users/madelinecraft/Desktop/103A Winter 2019/Week 1 Lab")
getwd()
mydata<-read.csv("edu_data.csv")
head(mydata)

#Calculate the proportion of people in this sample who go to school year round
frequencies <- table(mydata$yr_rnd)
denominator <- sum(frequencies)
denominator
numerator <- frequencies[2]
numerator
#p-hat = x/n
proportion <- numerator/denominator 
proportion

#Calculate the mean of meals 
mean(mydata$meals)

## INTERVAL ESTIMATE

#Calculate the confidence interval surrounding the proportion 
#p-hat + - z*sqrt((p-hat*(1-p-hat)/n))
#where p-hat is the point estimate of the population proportion 
#and the margin of error is z*SE(p-hat)
#and SE(p-hat) = sqrt((p-hat*(1-p-hat)/n))
?prop.test
prop.test(90, 315, alternative = c("two.sided"), conf.level = 0.95)
prop.test(90, 315, alternative = c("greater"), conf.level = 0.95)
prop.test(90, 315, alternative = c("less"), conf.level = 0.95)

#Calculate the confidence interval surrounding the mean
#x-bar + - z*(sd/sqrt(n)) (for n >30)
#What is the point estimate?
#What is the margin of error?
#What is the standard error of the point estimate?
t.test(mydata$meals, conf.level = 0.95)

## ANOTHER EXAMPLE

setwd("/Users/madelinecraft/Desktop/103A Winter 2019/Week 5 Lab")
gredata = read.csv('GRE_data.csv', header = TRUE) 
head(gredata)

#We are going to calculate another proportion 
table(gredata$admit)
#Here is another way to do what we already did in lines 7-14
x = table(gredata$admit)[1]
#Now let's calculate p-hat again
p_hat = x / nrow(gredata)	# Remember that nrow() is a function
                         				 	# that returns the number of rows in a
                      				      	# data set
p_hat 									# So the proportion of applicants 
											# admitted was about .32

#Next, we can construct another confidence interval 
#This time let's walk through the steps of obtaining a z critical value more carefully
#We'll use qnorm() to get the z critical value
#Because we are interested in getting a central area equal to .95, we need to divide the 
#remaining proportion by 2, so:
(1 - .95) / 2
# Now we can get our critical z value:
qnorm(.025, lower.tail = F)
# OR
qnorm(.95 + .025)
# Let's save one of these results:
zcritical = qnorm(.025, lower.tail = F)

#Now we need a measure of the uncertainty of our statistic
# For this, we estimate the standard deviation of the sampling distribution of p
sigma_p = sqrt((p_hat*(1 - p_hat)) / nrow(gredata)) 
#Remember order of operations!

#So now we have all of the pieces of information we need and we can construct 
#a 95% confidence interval
p_hat - zcritical*sigma_p # This is our lower bound
p_hat + zcritical*sigma_p # And our upper bound
#Our 95% confidence interval for our sample proportion is
#[.27, .36]. If we were to repeat this study over and over
#again, we would expect 95% of our contructed confidence 
#intervals to contain the true population proportion.

#It is important to realize that we do not know whether our confidence interval 
#contains the true population proporion or not!

#What would we need to do to get a 99% confidence interval?
#We can just change our critical z value:
zcritical99 = qnorm((1 - .99) / 2, lower.tail = F)

#And estimate our confidence interval again:
p_hat - zcritical99*sigma_p # Lower bound
p_hat + zcritical99*sigma_p # Upper bound

#Is this interval wider or narrower than our 95% confidence interval? Why?

## CONFIDENCE INTERVAL FOR A POPULATION MEAN ##
#####################################################

## CONFIDENCE INTERVAL WHEN SIGMA IS KNOWN

#If sigma (the population standard deviation) 
#is known and it is reasonable to believe that 
#the population distribution of scores is normal, 
#then we can use the following formula to construct 
#a confidence interval for the population mean:

#(sample mean) +/- (z critical value)(sigma / sqrt(n))

#What did we previously say that sigma / sqrt(n) was?
#This is the standard deviation of the sampling distribution
#of the mean, also known as STANDARD ERROR (SE)

#Let's use the GRE variable in our GRE data set to
#construct a confidence interval when sigma is known.

#Let's start by taking a look at the GRE variable.
#These are scores from the mathematics
#section of the GRE exam. These are based on the old
#GRE (prior to 2011) so scores ranged from 200-800,
#in 10 point increments.
hist(gredata$GRE)

#In 2009, the population SD (sigma) for the 
#mathematics section of the GRE for all 
#test-takers was 150.

#Becase we know sigma, we can easily construct
#our confidence interval.

#Start by getting our sample mean:
x_bar = mean(gredata$GRE, na.rm = T)
#There are no missing values in this data set,
#so the na.rm = T has no effect here.

#Now, let's get our standard error
se = 150 / sqrt(nrow(gredata))

#We already figured out the z critical value to construct
#a 95% confidence interval, so we will use that value again.

#Putting everything together, we get:
x_bar - zcritical * se # Lower bound
x_bar + zcritical * se # Upper bound

#And we get a 95% confidence interval of [573.00, 602.40]
#And how would we interpret this interval?

#If we were to repeat this study an infinite number of 
#times, we would expect the true population mean to fall
#within 95% of the confidence intervals. (We do not know 
#whether this interval contains the true population mean 
#or not!)

#And what would we do differently if we wanted to get,
#say, a 90% confidence interval?

#We could just change the z critical value and recompute
#our confidence interval:
zcritical90 = qnorm((1 - .90) / 2, lower.tail = F)

# Now using our new z critical value:
x_bar - zcritical90 * se # Lower bound
x_bar + zcritical90 * se # Upper bound

#And we get a 90% confidence interval of [575.36, 600.04]

## CONFIDENCE INTERVAL WHEN SIGMA IS UNKNOWN

#In practice, it is rare that we ever know the actual
#value for sigma, so instead we have to estimate
#this value from our sample data, which adds additional
#uncertainty in the estimation of our confidence intervals.

#When our sample size is large, we know that the 
#sampling distribution of the mean will be normally
#distributed, no matter if the population is normal
#or not, because of the central limit theorem.

#However, when the sample size is small, we cannot
#necessarily assume that the sampling distribution is normal.

#For smaller sample sizes, we can use a t-distribution.

#The t-distribution, like the z-distribution is symmetric and
#centered at a mean of 0. However, we need an additional
#parameter to describe the t-distribution, which is the
#degrees of freedom (df).

#At low df, the t-distribution has a greater proportion
#of observations in the tails than the standard normal
#distribution.

#As df increases, the t-distribution becomes closer and
#closer to the standard normal distribution.

#Let's simulate some values to visualize this.

#Note: I got lazy and took this code from the following source: 
#https://www.statmethods.net/advgraphs/probability.html

x = seq(-4, 4, length = 100)
hx = dnorm(x)

degf = c(1, 3, 8, 30)
colors = c('red', 'blue', 'darkgreen', 'gold', 'black')
labels = c('df = 1', 'df = 3', 'df = 8', 'df = 30', 'normal')

plot(x, hx, type = 'l', lty = 3, xlab = 'x value',
     ylab = 'Density', main = 'Comparison of t Distributions')

for (i in 1:4) {
  lines(x, dt(x, degf[i]), lwd = 2, col = colors[i])
}

legend('topright', inset = .05, title = 'Distributions',
       labels, lwd = 2, lty = c(1, 1, 1, 1, 2), col = colors)

#We have a set a functions to describe various aspects
#of the t-distribution, just like for the normal distribution:

#pt(q, df, ncp, lower.tail = TRUE, log.p = FALSE)
#qt(p, df, ncp, lower.tail = TRUE, log.p = FALSE)
#rt(n, df, ncp)

#And we can get critical t-values the same way we do 
#for critical z-values, but we need to also specify
#our degrees of freedom.


###From page 436 of your textbook:

###The One-Sample t Confidence Interval for mu

###The general formula for a confidence interval for a
###population mean mu based on a sample of size n when

###1. x bar is the sample mean from a simple random sample,

###2. the population distribution is normal, or the sample
###    size is large (generally n >= 30), and

###3. sigma, the population standard deviation is unknown is

###(sample mean) +/- (t critical value)(s / sqrt(n))

###where the t critical value is based on df = n - 1.


#Armed with this information, let's go back to our GRE 
#example, now assuming that we do not know the value of sigma.

#We already have our sample mean, x_bar, so now let's calculate our
#t critical value. We will assume a confidence level of 95%.

tcritical = qt((1 - .95) / 2, df = nrow(gredata) - 1, lower.tail = F)
#Note: here we need to specify df of n - 1

#And let's estimate the standard error for the GRE variable:

est.sigma = sd(gredata$GRE) / sqrt(nrow(gredata))

#And now, putting these pieces of information together:
x_bar - tcritical * est.sigma # Lower bound
x_bar + tcritical * est.sigma # Upper bound

#And we get a 95% confidence interval of [576.35, 599.05]

#How does this confidence interval compare to the one 
#using the known value of sigma?

#And we can easily change the confidence level by manipulating
#the t critical value as we did previously.