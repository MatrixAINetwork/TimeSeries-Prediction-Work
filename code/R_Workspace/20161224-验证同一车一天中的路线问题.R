# --查看239,0886在2016-05-20日的运行数据，看能不能识别出什么时间段跑了那个路线
# --查看239,0886在2016-04-20日的运行数据，有可能是header文件漏了当天其他路线的信息
# --可以确定的是：itf_3g_header中找到的某车某天跑了什么路线，但是当天可能还跑了其他路线，但是表中没有而已
function(){
  data<-read.csv("E:\\Data_Lab\\20161224-验证同一车一天中的路线问题\\239-0886-2016-04-20.csv", header = TRUE)
  speed<-data[,19]
  plot(speed, type = 'l')
  
  data<-read.csv("E:\\Data_Lab\\20161224-验证同一车一天中的路线问题\\239-0886-2016-05-20.csv", header = TRUE)
  speed<-data[,19]
  plot(speed, type = 'l')
}