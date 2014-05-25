Getting and Cleaning Data project
=================================
Introduction-
============

The purpose of this project is to collect, clean and generate new tidy dataset that can be used for later analysis.

Data
====

Data definition and the transformations/cleanup steps of run_analysis.R is fully documented in the CodeBook.md

Project Contents:
=================
Beside README.md file, the project directory also contains :

run_analysis.R
CodeBook.md, and
tidyData.txt
run_analysis.R is the only R script that used to collect, clean up and generate dataset that store the average of each measurement/features for each activity and subject.

CodeBook.md provide further explanation on the dataset and execution steps of the run_analysis.R script.

tidyData.txt is the tab delimited text file generated from the run_analysis.R script

Setup
=====

Download this project. Open R/RStudio and set your working directory to the downloaded project directory.

Open R/RStudio program and run the run_analysis.R script.

source('run_analysis.R')
The script will generate an output tab delimited text file tidyData.txt.
