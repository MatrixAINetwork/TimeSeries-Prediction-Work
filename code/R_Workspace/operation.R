tmp<-data.nob.231.1489.0805.allAxisTemp[,1]
plot(tmp, ylim = c(15,45))

tmp<-data.nob.0407[,5]
plot(tmp, ylim = c(15,45))

tmp<-data.nob.0407.col5
tmp<-tmp[!is.na(tmp)]
plot(tmp, type="l")
plot(tmp, type="l", xlim = c(100,200))

tmp<-data.nob.231.6073.0814.allAxisTemp[,3]
tmp[tmp==-100]<-NA
plot(tmp, type="l")
plot(tmp, type="l", xlim = c(0,2000))
plot(tmp, type="l", xlim = c(1000,2000))
plot(tmp, type="l", xlim = c(1400,1600))

data.nob.231.6073.0814.allAxisTemp.merge<-read.csv("F:\\sql_out\\231_无故障_多车型_一天数据\\out\\231_6073_2016-08-14_2_allAxisTemperature_merge.csv")
tmp<-data.nob.231.6073.0814.allAxisTemp.merge[,3]
tmp[tmp==-100]<-NA
plot(tmp, type="l")
plot(tmp, type="l", xlim = c(0,800))
plot(tmp, type="l", xlim = c(0,1000))

source("VAR_Data_Analysis.R")
func.var.jump(data.nob.231.6073.0814.allAxisTemp.merge)

source("var_jump.R")
func.jump()

source("VAR_Data_Analysis2.R")
func.test()


write.table(res[[6]],"163-0151-0630-6.txt", row.names = FALSE, col.names = FALSE)

for(i in 1:6){
  tmp1 <- res[[i]]
  tmp2 <- tmp1[,1:6]
  tmp2[,7:8] <- tmp1[,12:13]
  
  name <- "163-0151-0630-"
  name <- paste(name, i, sep = "")
  name <- paste(name, ".txt", sep = "")
  
  write.table(tmp2, name, row.names = FALSE, col.names = FALSE)
}

for(i in 1:6){
  
  tmp1 <- res[[i]]
  tmp2 <- tmp1[,1:6]
  tmp2[,7:8] <- tmp1[,12:13]
  
  for(j in 1:6){
    tmp3 <- tmp2[j]
    #tmp3[,2:3] <- tmp2[,7:8]
    
    name <- "163-0151-0630-"
    name <- paste(name, i, sep = "")
    name <- paste(name, "-", sep = "")
    name <- paste(name, j, sep = "")
    name <- paste(name, ".txt", sep = "")
    
    write.table(tmp3, name, row.names = FALSE, col.names = FALSE)
  }
}

source("data_process.R")
z<-data.nob.231.6073.0814.allAxisTemp.merge[1:1500,3]
#plot(z)
z<-func.data.rmNull(z)
y<-fft(z,inverse = FALSE)/length(z)
#plot(Re(y))
plot(Im(y))
plot(y)

yz<-fft(y,inverse = TRUE)/length(z)
plot(yz)

#FFT
function(){
  N<-1500#采样点数目，FFT后也是N个复数，本来是N/2个，但是根据对称后变成N个，常常取2的整数次方
  Fs<-1#采样频率=每秒钟采样个数,该频率只影响后面画图时的频率精度，其实可以随便设置，因为最后看的还是整体趋势
    
  source("data_process.R")
  z<-data.nob.231.6073.0814.allAxisTemp.merge[1:N,3]
  plot(z, type = "l")
  z<-func.data.rmNull(z)
  y<-fft(z,inverse = FALSE)
  
  Ayy<-Mod(y)#原始信号的峰值
  Ayy<-Ayy/(N/2)#实际的幅度值
  Ayy[1]<-Ayy[1]/2#第一点为直流分量
  F<-(1:N-1)*Fs/N#频率轴
  plot(F,Ayy, type = "l")
}
#FFT-例子1
function(){
  pi<-3.14
  t<-c()
  for(i in 1:256){
    t[i]<-i*(1/256)
  }
  S<-2+3*cos(2*pi*50*t-pi*30/180)+1.5*cos(2*pi*75*t+pi*90/180)
  #S<-3*cos(2*pi*50*t)
  plot(t,S,type = "l")
  
  Fs<-256
  N<-256
  y<-fft(S, inverse = FALSE)
  Ayy<-Mod(y)
  Ayy<-Ayy/(N/2)
  Ayy[1]<-Ayy[1]/2
  F<-(1:N-1)*Fs/N
  plot(F,Ayy,type = "l")
}
#FFT-例子2
function2(){
  n<-seq(0,1,0.001);
  A1<-4;
  A2<-4;
  f1<-25;
  f2<-50;
  pi<-3.14
  
  xn<-A1*sin(f1*2*pi*n)+A2*sin(f2*2*pi*n)
  
  Fs<-1000
  t<-0:1/Fs:1
  plot(1000*t[1:50], xn[1:50])
  
  
}

#输出data.163.0151.0711.allAxisTemp.merge的第一点
#输出data.163.0158.0810.allAxisTemp.merge的第一点
function(){
  tmp<-data.163.0151.0711.allAxisTemp.merge
  name <- "163-0151-0711-1-1.txt"
  write.table(tmp[,1], name, row.names = FALSE, col.names = FALSE)
  
  tmp<-data.163.0158.0810.allAxisTemp.merge
  name <- "163-0158-0810-1-1.txt"
  write.table(tmp[,1], name, row.names = FALSE, col.names = FALSE)
}

#跳变数据Plot
function(){
  tmp<-data.nob.231.6073.0814.allAxisTemp.merge
  plot(tmp[,3], type = "l")
  lines(tmp[,3], type = "o")
}


