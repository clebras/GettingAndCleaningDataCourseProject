# (Tidy) Human Activity Recognition Using Smartphones Dataset

Version 0.1 / 30JAN2020 submitted on [coursera.org](https://www.coursera.org/learn/data-cleaning/home/welcome) 

(See original [README_orig.txt][ORIG] for details on original dataset)

Summary
=======
The original dataset has been refactored and reorganized using a R script
run_analysis.R that provides some tidy dataset ('tibble' dataframe):
- dt_total (10299 observations of 1716 variables): tidy raw data
- dt_stats (180 observations of 81 variables): tidy data set with the average
  of some specific variables (i.e all mean and standard deviation variables) for each activity and each subject


Code book
=========
A detailled code book [CODEBOOK.txt][CODEBOOK] details the variables on each dataset provided.
This code book refers to 2 specific and new created files ([FEATURES.txt][FEAT] and [FEATURES_stats.txt][FEAT_STATS]) that details the 2 data set.

Compatibility
=============
The run_analysis.R has been tested on Windows 10 with:

| Software | Ver. |
| ------ | ------ |
| R version | 3.6.0 (2019-04-26)|
| RStudio | 1.2.1335|

It uses libraries:

| Library | Ver. |
| ------ | ------ |
| readr |1.3.1|
|tibble |2.1.3|
|dplyr |0.8.3|


Run
===
a) `Before starting the script`, please ensure your working session (see: setwd() command) contains the uncompressed original repository (that contains the original deflated dataset):
```sh
   ./getdata_projectfiles_UCI HAR Dataset
```
b) To start the script, type (on RStudio for example):
```sh
   source("run_analysis.R")
```
c) At the end, an abstract of dt_stats is displayed (using tibble::glimpse() command)
   
d) and a dt_stats.txt is generated


[//]: # ( --- thanks to https://dillinger.io/ ---)

[CODEBOOK]: <https://github.com/clebras/GettingAndCleaningDataCourseProject/blob/master/CODE%20BOOK.txt>
[FEAT]: <https://github.com/clebras/GettingAndCleaningDataCourseProject/blob/master/FEATURES.txt>
[FEAT_STATS]: <https://github.com/clebras/GettingAndCleaningDataCourseProject/blob/master/FEATURES_stats.txt>
[ORIG]: <https://github.com/clebras/GettingAndCleaningDataCourseProject/blob/master/README_orig.txt>
