func.jump<-function(){
  
  library("vars");
  
  allAxisTemp.merge<-data.nob.231.6073.0814.allAxisTemp.merge;
  source("VAR_Data_Analysis.R")
  
  #准备数据
  axleList<-func.var.data(allAxisTemp.merge)
  axle<-1
  sampleEndIndex<-800
  prdRange<-200
  data<-axleList[[axle]]
  
  #browser()
  
  #迭代VAR
  point<-3
  len<-nrow(data)
  tmp.modelSample<-data[1:sampleEndIndex,]
  tmp.prd.pre<-data[1:sampleEndIndex,point]
  while(sampleEndIndex<=len){
    
    #tmp.modelSample<-data[1:sampleEndIndex,]
    varest<-VAR(tmp.modelSample,lag.max = 10,ic=c("SC"));
    varprd<-predict(varest,n.ahead = prdRange,ci=0.05);
    
    #1.1预测区间
    tmp.ori.prd.point<-data[(sampleEndIndex+1):(sampleEndIndex+prdRange),point]
    tmp.prd.point<-varprd$fcst[[point]][,1];  
    res<-help.getCompare(tmp.ori.prd.point,tmp.prd.point)
    
    #将剔除高位数据后的数据存储起来，作为下一轮VAR
    tmp.prd.pre[(sampleEndIndex+1):(sampleEndIndex+prdRange)]<-res
    
    #1.2预测区间对比图
    min<-func.getMin(tmp.ori.prd.point,tmp.prd.point)
    max<-func.getMax(tmp.ori.prd.point,tmp.prd.point)
    plot(tmp.ori.prd.point, type="l", col=c("blue"), ylim=c(min,max))
    lines(tmp.prd.point,col=c("red"))
    lines(res,col=c("green"))
    
    #2.1样本区间
    tmp.ori<-data[1:(sampleEndIndex+prdRange),point];
    tmp.prd<-data[1:sampleEndIndex,point];
    tmp.prd[(sampleEndIndex+1):(sampleEndIndex+prdRange)]<-varprd$fcst[[point]][,1];
    tmp.remo<-data[1:sampleEndIndex,point];
    tmp.remo[(sampleEndIndex+1):(sampleEndIndex+prdRange)]<-res
    
    #2.2样本与预测对比图
    # plot(tmp.ori, type="l", col=c("blue"), xlab="Time Series", ylab="Tmperature")
    # lines(tmp.prd,col=c("red"))
    # lines(tmp.remo,col=c("green"))
    
    #plot(tmp.remo, type="l", col=c("blue"))
    
    #browser()
    
    sampleEndIndex<-sampleEndIndex+prdRange
    tmp.modelSample<-data[1:sampleEndIndex,]
    #tmp.modelSample[,point]<-tmp.prd.pre
    
    min<-func.getMin(tmp.prd.pre,tmp.ori)
    max<-func.getMax(tmp.prd.pre,tmp.ori)
    plot(tmp.ori, type="l", col=c("blue"), ylim=c(min,max))
    lines(tmp.prd.pre ,col=c("red"))
    
    browser()
    
  }
  
}

help.getCompare<-function(ori, prd){
  
  len<-length(ori)
  res<-c()
  for(i in 1:len){
    res[i]<-min(ori[i],prd[i])
  }
  
  return(res)
}
