Getdata-CourseProject
=====================

This repository contains three files: run_analysis.R, README.md, and CODEBOOK.md.  The code takes the UCI HAR Dataset and creates a tidy dataset.  The codebook contains all variables in the final dataset.

Code Explanation
----------------

The code should run in the same directory that the dataset is in (i.e. "./UCI HAR Dataset" and "./run_analysis.R").  Running the code in this directory outputs a wide, tidy dataset named "finaldatatable.txt".  The dataset can be read into R using the command: read.table("./finaldatatable.txt", header=TRUE).

Choices Made
------------

I chose to extract all variables that ended with mean() and std().  There was ambiguity regarding whether meanFreq (and other variables containing "mean") should be included, but I decided to omit those since it wasn't the mean of the variable, but rather the mean of the frequency of the variable.

Furthermore, I chose to name the variable names using lowerCamelCase.  Choosing all lowercase letters (per the lecture notes) would make the variable names quite hard to read.  All abbreviations in the original feature names have been replaced with their longer form to improve clarity of the variables.
