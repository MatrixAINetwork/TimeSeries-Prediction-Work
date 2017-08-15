#rm array null
func.data.rmNull<-function(data){
  len<-length(data)
  index<-1
  res<-c()
  for(i in 1:len){
    if(data[i] != -100){
      res[index]<-data[i]
      index<-index+1
    }
  }
  
  return(res)
}