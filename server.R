
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
esc<-read.table(url("https://raw.githubusercontent.com/weddy5132/escyc/master/escsj.txt"),sep="",header=TRUE)
#esc<-reactive({read.table(url("https://raw.githubusercontent.com/weddy5132/shiny/613cff20e1889aa8fa405487976894cbfaa41f5b/escyc"),sep="",header=TRUE)})
#https://raw.githubusercontent.com/weddy5132/escyc/master/escsj.txt
predict_net<-function(test,data){
  set.seed(10) 
  library(grid)
  library(MASS)
  library(neuralnet)
  nrows=nrow(data)
  ncols=ncol(data)
  scaled.data<- as.data.frame(scale(data))
  data.mean=colMeans(data[,1:2])
  data.sd=sqrt(apply(data[,1:2],2,var))
  input1=scaled.data[,1]
  input2=scaled.data[,2]
  output=scaled.data[,ncols]
  net.training=neuralnet(output~input1+input2,scaled.data,hidden=1,threshold=0.01)
  scaled.test=(test-data.mean)/data.sd
  scaled.testdata=rbind(scaled.data[,1:2],scaled.test)
  net.result=compute(net.training,scaled.testdata)
  netresults=net.result$net.result*sd(data[,3])+mean(data[,3])
  netresults[(nrows+1)]
} 
# Define server 
shinyServer(function(input,output) {
  output$predict<- renderPrint({
  test=predict_net(c(input$years,input$miles),esc())
  print(test)
  })
})