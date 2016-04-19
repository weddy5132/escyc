
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("二手车交易价格预测"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      #选择数据文件上传
      #fileInput('file1', 'Choose CSV File',accept=c('text/csv', 'text/comma-separated-values,text/plain')),
      #调节按钮框选择数据，输入数据
      numericInput("years", "二手车已使用年数(年）:", 3,step=0.1),
      #条状选择输入数据
      numericInput("miles","二手车已行驶里程数（KM):",min=0,3,step=0.1),
      #提示帮助文档的显示
      helpText("Note: 已使用年数=现在时间-上牌时间，里程数单位为公里数"), 
      #所有输入条件的更新确认按钮
      submitButton("Update View")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      #应用server.R中output$predict，输出表格形式结果
       textOutput("predict")
    )
  )
))