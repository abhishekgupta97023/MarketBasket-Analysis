setwd("C:/Users/raj-pc/Desktop/R")
getwd()
groceries<-read.csv("groceries.csv")
print(groceries)

is.data.frame(groceries)
View(groceries)
str(groceries)
install.packages("arules")
library(arules)

transaction_groceries <- read.transactions("groceries.csv",sep = ",")

length(transaction_groceries)
View(transaction_groceries)
summary(transaction_groceries)
inspect(transaction_groceries[1:5])


itms <-itemFrequency(transaction_groceries,type="absolute")
sorted_items <- sort(itms,decreasing = TRUE)
itemFrequencyPlot(sorted_items,topN=20,type="absolute",col=rainbow(20))
print(itms)
sum_total <-sum(itms)

top20 <- head(sort(itms, decreasing = TRUE), n = 20)
View(top20)


sum_top20 <-sum(top20)

accountng <- (sum_top20 /sum_total)*100
(accountng)


transaction_groceries[, 1:5]
itemFrequencyPlot(transaction_groceries,topN=20,type="absolute",col=rainbow(20))

?itemFrequency


# Get the rules
rules <- apriori(transaction_groceries, parameter = list(supp = 0.001, conf = 0.8))
summary(rules)

# Show the top 5 rules, but only 2 digits
options(digits=2)
inspect(rules[1:10])
plot()

rules<-sort(rules, by="lift", decreasing=TRUE)
write(rules, file = "groceryrules.csv", sep = ",", quote = TRUE, row.names = FALSE)
print(rules)
summary(rules)
inspect(rules)
itemFrequencyPlot(items(rules))

install.packages("arulesViz")
library(arulesViz)
plot(rules,method="graph",engine="interactive",shading=NA)