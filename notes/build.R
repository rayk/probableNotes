# Title     : build
# Objective : Builds the outputed notebook.
# Created by: rayk
# Created on: 18/12/20

library('bookdown')

bookdown::render_book('index.Rmd', 'bookdown::gitbook')


