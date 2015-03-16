library(shiny)
fitMPG<-lm(mpg~cyl+am+wt+disp,data=mtcars)
fitHP<-lm(hp~cyl+disp,data=mtcars)
shinyServer(
  function(input, output) {
    output$cyl<-renderPrint({input$cyl})
    output$wt<-renderPrint({input$wt})
    output$disp<-renderPrint({input$disp})
    output$am<-renderPrint({if(input$am==0) "Automatic" else "Manual"})
    
    output$mpg<-renderPrint({predictMPG(input$cyl,input$wt,input$disp,input$am)})
    output$hp<-renderPrint({predictHP(input$cyl,input$wt,input$disp,input$am)})
    
    output$carPlot<-renderPlot({
      plot(
        predictMPG(input$cyl,input$wt,input$disp,input$am),
        predictHP(input$cyl,input$wt,input$disp,input$am),
        xlab="Miles per gallon",
        ylab="Horsepower",
        main="Your car's performance versus the other mtcars",
        col="red",
        cex=3,
        pch=20,
        xlim=c(5,35),
        ylim=c(70,250)
      )
      legend(4,250,c("Mean MPG","Mean HP","Your car","4 Cyl","6 Cyl","8 Cyl"),title="All mtcars")
      lines(c(4,4.8),c(228,228),col="red")
      lines(c(4,4.8),c(218,218),col="blue")
      lines(c(mean(mtcars$mpg),mean(mtcars$mpg)),c(0,300),col="red")
      lines(c(0,300),c(mean(mtcars$hp),mean(mtcars$hp)),col="blue")
      points(mtcars$mpg,mtcars$hp,col=mtcars$cyl,pch=19)
      points(4.3,208,col="red",cex=3,pch=20)
      points(4.3,198,col=4,pch=19)
      points(4.3,188,col=6,pch=19)
      points(4.3,178,col=8,pch=19)
    })
  }
)

predictMPG<-function (cyl,wt,disp,am) {
  n<-c(as.numeric(cyl),as.numeric(wt),as.numeric(disp),as.numeric(am))
  n<-as.data.frame(rbind(n))
  names(n)<-c("cyl","wt","disp","am")
  
  predict(fitMPG,newdata=n)  
}

predictHP<-function (cyl,wt,disp,am) {
  n<-c(as.numeric(cyl),as.numeric(wt),as.numeric(disp),as.numeric(am))
  n<-as.data.frame(rbind(n))
  names(n)<-c("cyl","wt","disp","am")
  
  predict(fitHP,newdata=n)  
}
