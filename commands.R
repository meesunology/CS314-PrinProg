# the R commands in this file produce a pdf file, named pageshist.pdf of 
# the numbers in the file named data
pdf(file="pageshist.pdf")
d<-read.table("data")
attach(d)
hist(V1)
