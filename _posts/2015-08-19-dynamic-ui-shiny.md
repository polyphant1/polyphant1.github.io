---
layout: post
title: "Creating dynamic UI components in Shiny"
comments: true
date: "Wednesday, August 19, 2015"
featured_image: /images/hdf.gif
tags:
- Data Science
excerpt:
---

I was recently trying to implement some dynamic functionality in Shiny. The aim was to have a set number of UI elements load depending on a numeric value entered by the user, and then use the data input in these elements later in the app.

I found the following thread on [SO](http://stackoverflow.com/questions/19130455/create-dynamic-number-of-input-elements-with-r-shiny/32089489#32089489) by someone having the same issue. The first answer details how to create a series of UI elements dynamically; the following snippet shows a similar example that creates a series of `numericInput` elements depending on the value entered in the drop down,

```r
# server.R

output$input_ui <- renderUI({
    num <- as.integer(input$num)

    lapply(1:num, function(i) {
      numericInput(paste0("n_input_", i), label = paste0("n_input", i), value = 0)
    })
})

# ui.R

selectInput("num", "select number of inputs", choices = seq(1,10,1))
uiOutput("input_ui")
```

This is relatively simple, however the OP goes on to ask how to actually use the values within these elements. This is a bit tricky, as each element has to have a unique name, and accessing these named variables isn't straightforward using the common Shiny syntax. I had a Google around, and found the following [ thread](https://groups.google.com/forum/#!topic/shiny-discuss/YAboU6gxrEw), where Joe Cheng himself (the original developer of Shiny) chipped in with an elegant solution. The following syntax allows you to access input variables named dynamically,

```r
input[["dynamically_named_variable"]]
```

Using this, we can simply access our iteratively named variables by constructing the appropriate strings within this call. I do this for each of the `numericInput` elements initialised above, and construct a table from the users input.

```r
# server.R

output$table <- renderTable({
    num <- as.integer(input$num)

    data.frame(lapply(1:num, function(i) {
      input[[paste0("ind", i)]]
    }))
  })

# ui.R

tableOutput("table")
```

You can see this in action as a Shiny app [here](https://polyphant.shinyapps.io/dynamic_ui). A gist of the complete app code is available [here](https://gist.github.com/polyphant1/b7ecdf8b0aa82c20fa46).
