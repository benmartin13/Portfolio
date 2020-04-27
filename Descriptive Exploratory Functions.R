#univariate
library(car)
?Prestige

#continuous variable-statistics
library(dplyr)
glimpse(Prestige)
summary(Prestige)
library(mosaic)
favstats(Prestige$income)
favstats(Prestige$income~Prestige$type)

library(pastecs)
stat.desc(Prestige$income,basic=FALSE,norm=TRUE)
round(stat.desc(Prestige$income,basic=F,norm=TRUE),digits=2) ##skew.2se and kurt.2se - skew/kurt over 
                                                             ##respective 2se relative to 1 shows significance
density(Prestige$income)
plot(density(Prestige$income))

#missing data
is.na(Prestige)
sum(is.na(Prestige$income))
sum(is.na(Prestige))
library(skimr)
skim(Prestige)

#continuous variable-plots
boxplot(Prestige$income,notch=T,horizontal=T,xlab="minutes",main="eruption time")
##notch gives visual indicator of 95% CI of population median
boxplot(Prestige$income~Prestige$type,notch=T,horizontal=T,xlab="minutes",main="eruption time")
hist(Prestige$income,breaks="FD", col="gray",ylim=c(0,30))
rug(Prestige$income) ##marks exact values under hist, shows distribution within a bar of hist
box()
plot(density(Prestige$income)) ##resamples from data to develop predictive distribution
qqnorm(Prestige$income)  #quantile plot w normal reference line
qqline(Prestige$income)
with(Prestige, qqPlot(income))

##Can use Z scores to identify outliers, but they are not robust to outliers, so Boxplots are better


#cut a continuous variable into quantile-based groups
library(Hmisc)
?faithful
plot(density(faithful$eruptions))
summary(faithful$eruptions)
eruptions2=cut2(faithful$eruptions,g=2)   
table(eruptions2)
barplot(table(eruptions2))

#bivariate

#scatterplot matrix 
pairs(Prestige)
library(car)
library(MASS)
scatterplotMatrix(Prestige, plot.points=TRUE, smoother=loessLine)
#scatterplot
plot(Prestige$education,Prestige$income)
scatter.smooth(Prestige$education,Prestige$income)

scatterplot(salary~yrs.since.phd,     
            data=Salaries,
            smooth=list(smoother=loessLine,
                        span=.5,
                        lty.smooth=1,
                        col.smooth="red"),
            id=T)
    ####REALLY GOOD TOOL


library(lattice)
#density plots by factor level 
densityplot(~Prestige$income|Prestige$type)
# scatterplots by factor 
xyplot(Prestige$income~Prestige$education|Prestige$type,
       grid=T,
       type = c("p","smooth"), col.line="red",lwd=2)
xyplot(Prestige$income~Prestige$education,
       grid=T,
       group=Prestige$type,
       type = c("p","smooth"),lwd=2)

#boxplots and statistics by levels of a factor
boxplot(Prestige$income~Prestige$type,notch=F)
Boxplot(Prestige$income~Prestige$type,data=Prestige)  #in car, labels outliers
tapply(Prestige$income,Prestige$type,summary)  
favstats(Prestige$income~Prestige$type)

#correlation matrix
str(Prestige)
new <- Prestige[, c(1:5)]
str(new)
round(cor(new, method="spearman"),digits=2) ##least squares corr - parametric
round(cor(new, method="pearson"),digits=2)  ##linear corr - nonparametric

#tables and statistics for 2 factors
library(ISLR)  #for Default data
def=table(Default$default,Default$student,dnn=list("default","student"))
def
mosaicplot(def)
addmargins(def)
prop.table(def)
#contingency table effect size statistics
library(vcd)
assocstats(def)


scatterplotMatrix(~education+income+women+prestige,
                  data=Prestige,
                  col=1,
                  smooth=list(smoother=loessLine, 
                              spread=F, lty.smooth=1,
                              col.smooth="red"),
                  regLine=list(method=lm, col="blue"),
                  plot.points=TRUE, 
)
scatterplot(income~ ,data=Prestige)


#coplots
library(lattice)
coplot(income~prestige | women, data=Prestige, number=3, columns=3,
       panel=function(x,y,...) {
         panel.smooth(x,y,span=.8,iter=5,...)
         abline(lm(y ~ x), col="blue") } )
coplot(income~prestige | education, data=Prestige, number=3, columns=3,
       panel=function(x,y,...) {
         panel.smooth(x,y,span=.8,iter=5,...)
         abline(lm(y ~ x), col="blue")
       } )
coplot(income~prestige | education*women, data=Prestige, number=3, columns=3,
       panel=function(x,y,...) {
         panel.smooth(x,y,span=.8,iter=5,...)
         abline(lm(y ~ x), col="blue")
       } )
