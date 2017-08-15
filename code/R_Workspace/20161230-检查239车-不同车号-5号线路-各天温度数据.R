
#----------------------------------------------------------------------------------------------
#根据数据1轴1位的数据图，将多缺省、少缺省的数据挑出来
function(){
  
  #获得文件夹下的文件列表
  source("common_function.R")
  dirname = "E:\\Data_Lab\\20161229-239型-不同车号-5线路-itf_6a-当日数据\\out"
  res = func.getFileListFromDir(dirname);
  filelist = res$filelist
  
  #browser()
  
  #遍历文件
  len = length(filelist)
  for(i in 1:len){
    #读取文件
    filename = filelist[i];
    data = read.csv(filename, header = TRUE)

    #检查文件数据
    tmp = data[,1]
    plot(tmp, main = res$filenames[i])

  }
}

#----------------------------------------------------------------------------------------------
#查看少缺省的数据图变化特性
function(){
  
  #检查例子
  filename = "";
  
  #遍历文件
  len = length(filelist)
  for(i in 1:len){
    #读取文件
    filename = filelist[i];
    data = read.csv(filename, header = TRUE)
    
    #检查文件数据
    tmp = data[,1]
    plot(tmp, main = res$filenames[i])
    
  }
}






















