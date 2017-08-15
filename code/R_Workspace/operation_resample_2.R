#在不分状态的情况下进行预测
#样本来源：重采样后的所有数据
#预测长度：c(1,2,3,4,5,6,7,8,9,10,11,12)*10 和 c(3,4,5,10,20,30,40,50,60,90,120,150,180)*60
resample.var.allsample.prediction<-function(){
  source("VAR_Data_Analysis2.R")
  
  data.reg<-read.csv("E:\\Data_Lab\\163_重采样\\allaxistemperature_merge_interval_10\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  data.reg.attr<-data.reg[,2:69]
  
  #先获得一轴一位数据
  #data.reg.out
  #=temperature of axle 1 + environment temperature +common atrributes 
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  
  #截取全数据中间段预测
  data.reg.out<-data.reg.out[1:4000,]
  
  len_row<-nrow(data.reg.out)
  
  #set the prediction length list
  prdList1<-c(1,2,3,4,5,6,7,8,9,10,11,12)*10
  prdList2<-c(3,4,5,10,20,30,40,50,60,90,120,150,180)*60
  
  #VAR
  for(i in 1:length(prdList1)){
    data<-data.reg.out
    prdRange<-prdList1[i]/10
    sampleEndIndex<-(len_row-prdRange)
    t_s<-Sys.time()
    res<-func.var(data, sampleEndIndex, prdRange, 0)
    t_e<-Sys.time()

    print(res$colist[[5]])
    print(t_e-t_s)

    browser()
  }
  for(i in 1:length(prdList2)){
    data<-data.reg.out
    prdRange<-prdList2[i]/10
    sampleEndIndex<-(len_row-prdRange)
    t_s<-Sys.time()
    res<-func.var(data, sampleEndIndex, prdRange, 0)
    t_e<-Sys.time()

    print(res$colist[[5]])
    print(t_e-t_s)
    
    browser()
  }
}
#在不分状态的情况下进行预测
#样本来源：重采样后的所有数据
#预测长度：c(1,2,3,4,5,6,7,8,9,10,11,12)*10 和 c(3,4,5,10,20,30,40,50,60,90,120,150,180)*60
#同resample.var.allsample.prediction
#添加原始数据与预测数据的对比+图形输出
resample.var.allsample.prediction2<-function(){
  source("VAR_Data_Analysis2.R")
  
  data.reg<-read.csv("E:\\Matlab_Workspace\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  data.reg.attr<-data.reg[,2:69]
  
  #先获得一轴一位数据
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  
  len_row<-nrow(data.reg.out)
  
  #set the prediction length list
  prdList1<-c(1,2,3,4,5,6,7,8,9,10,11,12)*10
  prdList2<-c(3,4,5,10,20,30,40,50,60,90,120,150,180)*60
  
  #VAR
  info.maxError<-c(NULL)
  info.time<-c(NULL)
  for(i in 1:(length(prdList1)+length(prdList2))){

    if(i>=1 && i<=length(prdList1)){
      prdRange<-prdList1[i]/10
    }else{
      prdRange<-prdList2[i-length(prdList1)]/10
    }
    data<-data.reg.out
    sampleEndIndex<-(len_row-prdRange)
    t_s<-Sys.time()
    res<-func.var(data, sampleEndIndex, prdRange, 0)
    t_e<-Sys.time()
    
   # browser()
    
    #观测数据与预测数据对比
    #预测部分数据
    point<-3
    data.ori<-res$colist[[point]]$ori
    data.prd<-res$colist[[point]]$prd
    #图度量衡
    min<-func.getMin(data.ori,data.prd)
    max<-func.getMax(data.ori,data.prd)
    #预测部分对比
    f<-"resample_pic_"
    f<-paste(f,prdRange, sep = "")
    f<-paste(f,"_1_", sep = "")
    f<-paste(f,".wmf", sep = "")
    win.metafile(filename = f)
    plot(data.ori, type="l", ylim=c(min,max),col=c("blue"), xlab="Time Series", ylab="Tmperature")
    lines(data.prd,col=c("red"))
    dev.off()
    #全局数据
    data.ori.all<-data.reg.out[,point]
    data.prd.all<-data.reg.out[,point]
    data.prd.all[(len_row-prdRange+1):len_row]<-data.prd
    #全局趋势对比
    f<-"resample_pic_"
    f<-paste(f,prdRange, sep = "")
    f<-paste(f,"_2_", sep = "")
    f<-paste(f,".wmf", sep = "")
    win.metafile(filename = f)
    plot(data.ori.all, type="l", col=c("blue"), xlab="Time Series", ylab="Tmperature")
    lines(data.prd.all,col=c("red"))
    dev.off()
    
    #browser()
    
    info.maxError[i]<-res$colist[[point]]$maxError
    info.time[i]<-t_e-t_s
    
    # print(prdRange*10/60)
    # print(res$colist[[point]]$maxError)
    # print(t_e-t_s)
    
   # browser()
  }
  #browser()
  out.info<-matrix(1:(length(info.maxError)*2),length(info.maxError),2)
  out.info[,1]<-info.maxError
  out.info[,2]<-info.time
  write.table(out.info,"errorRatio.txt",row.names = FALSE, col.names = FALSE, quote = FALSE)
}

#同resample.var.allsample.prediction2
#1.添加lag输出
#2.修改图的输出方式：原数据+预测数据+预测误差
resample.var.allsample.prediction3<-function(){
  source("VAR_Data_Analysis2.R")
  
  data.reg<-read.csv("E:\\Matlab_Workspace\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  data.reg.attr<-data.reg[,2:69]
  
  #先获得一轴一位数据
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  
  len_row<-nrow(data.reg.out)
  
  #set the prediction length list
  prdList1<-c(1,2,3,4,5,6,7,8,9,10,11,12)*10
  prdList2<-c(3,4,5,10,20,30,40,50,60,90,120,150,180)*60
  
  #VAR
  info.maxError<-c(NULL)
  info.time<-c(NULL)
  for(i in 1:(length(prdList1)+length(prdList2))){
    
    if(i>=1 && i<=length(prdList1)){
      prdRange<-prdList1[i]/10
    }else{
      prdRange<-prdList2[i-length(prdList1)]/10
    }
    data<-data.reg.out
    sampleEndIndex<-(len_row-prdRange)
    t_s<-Sys.time()
    res<-func.var(data, sampleEndIndex, prdRange, 0)
    t_e<-Sys.time()
    
    # browser()
    
    #观测数据与预测数据对比
    #预测部分数据
    point<-3
    data.ori<-res$colist[[point]]$ori
    data.prd<-res$colist[[point]]$prd
    #图度量衡
    min<-func.getMin(data.ori,data.prd)
    max<-func.getMax(data.ori,data.prd)
    #预测部分对比
    f<-"resample_pic_"
    f<-paste(f,prdRange, sep = "")
    f<-paste(f,"_1_", sep = "")
    f<-paste(f,".wmf", sep = "")
    win.metafile(filename = f)
    plot(data.ori, type="l", ylim=c(min,max),col=c("blue"), xlab="Time Series", ylab="Tmperature")
    lines(data.prd,col=c("red"))
    dev.off()
    #全局数据
    data.ori.all<-data.reg.out[,point]
    data.prd.all<-data.reg.out[,point]
    data.prd.all[(len_row-prdRange+1):len_row]<-data.prd
    #全局趋势对比
    f<-"resample_pic_"
    f<-paste(f,prdRange, sep = "")
    f<-paste(f,"_2_", sep = "")
    f<-paste(f,".wmf", sep = "")
    win.metafile(filename = f)
    plot(data.ori.all, type="l", col=c("blue"), xlab="Time Series", ylab="Tmperature")
    lines(data.prd.all,col=c("red"))
    dev.off()
    
    #browser()
    
    info.maxError[i]<-res$colist[[point]]$maxError
    info.time[i]<-t_e-t_s
    
    print("lag:")
    print(res$varest$p)
    print("\n")
    
    # print(prdRange*10/60)
    # print(res$colist[[point]]$maxError)
    # print(t_e-t_s)
    
    # browser()
  }
  #browser()
  out.info<-matrix(1:(length(info.maxError)*2),length(info.maxError),2)
  out.info[,1]<-info.maxError
  out.info[,2]<-info.time
  write.table(out.info,"errorRatio.txt",row.names = FALSE, col.names = FALSE, quote = FALSE)
}

#同resample.var.allsample.prediction3
#1.添加lag输出
#2.修改图的输出方式：原数据+预测数据+预测误差
resample.var.allsample.prediction4<-function(){
  source("VAR_Data_Analysis2.R")
  
  data.reg<-read.csv("E:\\Matlab_Workspace\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  data.reg.attr<-data.reg[,2:69]
  
  #先获得一轴一位数据
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  
  len_row<-nrow(data.reg.out)
 
  #VAR
  info.maxError<-c(NULL)
  info.time<-c(NULL)
   
    prdRange<-180*60/10
    
    data<-data.reg.out
    sampleEndIndex<-(len_row-prdRange)
    t_s<-Sys.time()
    res<-func.var(data, sampleEndIndex, prdRange, 0)
    t_e<-Sys.time()
    
    # browser()
    
    #观测数据与预测数据对比
    #预测部分数据
    point<-2
    data.ori<-res$colist[[point]]$ori
    data.prd<-res$colist[[point]]$prd
    #图度量衡
    min<-func.getMin(data.ori,data.prd)
    max<-func.getMax(data.ori,data.prd)
    #预测部分对比
    f<-"resample_pic_"
    f<-paste(f,prdRange, sep = "")
    f<-paste(f,"_1_", sep = "")
    f<-paste(f,".wmf", sep = "")
    win.metafile(filename = f)
    plot(data.ori, type="l", ylim=c(min,max),col=c("blue"), xlab="Time Series", ylab="Tmperature")
    lines(data.prd,col=c("red"))
    dev.off()
    #全局数据
    data.ori.all<-data.reg.out[,point]
    data.prd.all<-data.reg.out[,point]
    data.prd.all[(len_row-prdRange+1):len_row]<-data.prd
    #全局趋势对比
    f<-"resample_pic_"
    f<-paste(f,prdRange, sep = "")
    f<-paste(f,"_2_", sep = "")
    f<-paste(f,".wmf", sep = "")
    win.metafile(filename = f)
    plot(data.ori.all, type="l", col=c("blue"), xlab="Time Series", ylab="Tmperature")
    lines(data.prd.all,col=c("red"))
    dev.off()
    
    #browser()
    
    info.maxError[i]<-res$colist[[point]]$maxError
    info.time[i]<-t_e-t_s
    
    print("lag:")
    print(res$varest$p)
    print("\n")
    
    # print(prdRange*10/60)
    # print(res$colist[[point]]$maxError)
    # print(t_e-t_s)
    
    # browser()

  #browser()
  out.info<-matrix(1:(length(info.maxError)*2),length(info.maxError),2)
  out.info[,1]<-info.maxError
  out.info[,2]<-info.time
  write.table(out.info,"errorRatio.txt",row.names = FALSE, col.names = FALSE, quote = FALSE)
}