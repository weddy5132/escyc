getRaw <- function(){
  data<-read.csv(url("https://raw.githubusercontent.com/weddy5132/escyc/master/escsj.csv"),sep=",",header=TRUE)
  data
}

