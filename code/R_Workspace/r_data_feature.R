
setwd("E:\\R_Workspace")
data.reg<-read.csv("E:\\Matlab_Workspace\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
data.reg.attr<-data.reg[,2:69]

#先获得一轴一位数据
data.reg.out.com<-data.reg.attr[,52:56]
data.reg.out.axle<-data.reg.attr[,1:6]
data.reg.out.hw<-data.reg.attr[,57:58]
data.reg.out<-data.reg.out.axle
data.reg.out[,7:8]<-data.reg.out.hw
data.reg.out[,9:13]<-data.reg.out.com

data<-data.reg.out

plot(data[,1])
acf(data[,1])
pacf(data[,1])

test.entropy <- function(d){
  
  print(d)
  res <- 0
  for(i in 1:length(d))
  {
    if(d[i]!=0)
      res <- res + d[i]*log(d[i])
  }
  return (-res)
}
test.entropy(data[,2])

library("entropy")
entropy(data[,1])
