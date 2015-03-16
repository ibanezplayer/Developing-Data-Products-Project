library(shiny)
shinyUI(
  fluidPage(
    titlePanel("Designing A More Efficient Car"),
    sidebarLayout(
      sidebarPanel(style = "padding:5pt;background-color:#CCCCCC;",
        h3('Select your car options'),
        sliderInput('cyl', 'How many cylinders in the engine?', 4, min = 4, max = 8, step = 2),
        sliderInput('wt', 'What is the car weight (in units of 1,000lbs)?', 1, min = 1.5, max = 5.5, step = .01),
        sliderInput('disp', 'What is the engine size (in cubic centimeters)?', 160, min = 70, max = 500, step = 10),
        radioButtons('am', 'Which transmission type?', 
                              c('Automatic' = '0',
                              'Manual' = '1'))
      ),
    mainPanel(style = "padding:5pt;",
      tabsetPanel(
        tabPanel("Overview",
                 h4("Designing A More Efficient Car"),
                 p("The mtcars dataset in R was extracted from the 1974 Motor Trend US 
                    magazine, and comprises fuel consumption and 10 aspects of automobile 
                    design and performance for 32 automobiles (1973-74 models)."),
                 p("This application fits a linear model for Miles Per Gallon (mpg) and
                    Horsepower (hp) using car specifications based on what was observed in
                    the Motor Trend report."),
                 p("The mpg model: fitMPG<-lm(mpg~cyl+am+wt+disp,data=mtcars)"),
                 p("Key attributes contributing to mpg: # of cylinders, transmission type, 
                    car weight, and engine size."),
                 p("The hp model: fitHP<-lm(hp~cyl+disp,data=mtcars)"),
                 p("Key attributes contributing to hp performance: # of cylinders and engine size."),
                 h4("Instructions"),
                 p("Use the inputs on the left-hand side of this application to change 
                    the key factors known to effect mpg and hp performance. You can then
                    see a summary of the specifications you selected under the Car Specs
                    tab, and see how well your car will perform relative to the other cars
                    in the mtcars dataset by view the Car Performance tab.")
        ),
        tabPanel("Car Specs",
          h4('Number of Cylinders selected:'),
          uiOutput("cyl"),
          h4('Weight selected:'),
          uiOutput("wt"),
          h4('Transmission type:'),
          uiOutput("am"),
          h4('Engine size (cc):'),
          uiOutput("disp")
        ),
        tabPanel("Car Performance",
          h4('Your estimated MPG:'),
          uiOutput("mpg"),
          h4('Your estimated Horsepower:'),
          uiOutput("hp"),
          plotOutput("carPlot")
        )
      )
    ))
)
)

