###  Data Wrangling Tutorial ###
# https://ucsb-bren.github.io/env-info/wk03_dplyr/wrangling-webinar.pdf
#
# Data sets needed: iris, mtcars, pressure
data(iris)
data(mtcars)
data(pressure)
# View data
View(iris)
View(mtcars)
View(pressure)
# install package devtools and EDAWR (lib) - EDAWR contains all data used in this tutorial
install.packages("devtools")
devtools::install_github("rstudio/EDAWR") 
# libraries used 
library(dplyr)
library(EDAWR)
#
# Pipe operator %>%
View(tb)
tb %>% select(child:elderly) # same as ..
select(tb, child:elderly)
#
# Why do we do data wrangling?
# 1 Make data suitable to use with a piece of software
# 2 Reveal information
# Get a column 
storms$wind
storms[,2] # will gives results horizontally
#
#Get the names withou a certain column
names(cases)[-1]
names(cases)[c(1,3)]
# Unlist simplifies df to produce a vectors that contains all atomic components which occur in x
unlist(cases[1:3,2:4])
# Get specific rows from a certain column
pollution$city[c(1,3,5)] # Author has a typo. He doesn't add the c()
pollution$amount[c(1,3,5)]
#Divide two columns of a df by each other
storms$wind / storms$pressure 
#
#
# tidyr package: To reshape the layout of tables
# Main functions: 1) gather() 2) spread()
library(tidyr)
?gather # Collapses multiple columns into two columns:
# 1) a key column that contains the former column names
# 2) a value column that contains the former column cells
gather(cases, "year","n", 2:4) # cases is df to reshape, "year" is name of new column, 
#.. "n" is name of new value column, 2:4 names of numeric indexes of columns to collapse
#

?spread # Generate multiple columns from two columns:
# 1) Each unique value in the key column becomes a column name
# 2) Each value in the value column becomes a cell in the new columns
spread(pollution,size,amount) # pollution is df to reshape, size is column to use for keys (new columns names),
#.. amount is column to use for values (new column cells)
#
#
# Separate and Unite
# Separate turns a single character column into multiple columns
storms_separated<-separate(storms, date, c("year","month","day"), sep="-")
#
#
# Unite unites columns into a single column
unite(storms_separated,"date",year,month,day,sep="-")
#
#
# dplyr package: To transform tabular data
library(dplyr)
?select # keeps only the variables you mention
?rename # keeps all variables.
?filter # finds rows/cases where conditions are true. Unlike base subsetting, rows where the condition evaluates 
#.. to NA are dropped.
?arrange # Sorts a variable in descending order
?mutate # adds new variables and preserves existing 
?transmute # drops existing variables
?summarize # Used on grouped data created by group_by(). The output will have one row for each group
?group_by # takes an existing tbl and converts it into a grouped tbl where operations are performed "by group".
?ungroup # removes grouping
#
#Install package "nycflights13" for flights that departed from NYC in 2013
install.packages("nycflights13")
library(nycflights13)
#
#
# Ways to access information: 
select() # Extracts existing variables
filter() # Extracts existing observations
mutate() # Derive new variables from existing variables
summarise() # Change the unit of analysis. Note summarise with an s not a z

# select()
select(storms,storm,pressure) # selects from the dataset storms the two columns storm and pressure
select(storms, pressure, storm) # selects from the dataset storms the two columns but puts pressure before storm 
select(storms, -storm) # selects from the dataset storms all the columns except the column storm
?select # you can add to it start_with("pet") or end_with("abc") 
select(storms, wind:date) # selects all columns from wind to date
# Useful select functions 
select(storms, matches("pressure")) # selects columns whoe name matches a regular expression
#
#
# filter()
filter(storms, wind >= 50)
# Another way to do the above command
storms %>%
  filter(wind >= 50)
#
filter(storms, wind >= 50, storm %in% c("Alberto","Alex","Allison"))   # Alex won't show because wind is not >= 50 for Alex
#
#
# Logical Tests in R
# <, >, ==, <=, >=, !=, %in% (Group membership), is.na (is NA),  !is.na (is not NA), 
# & (boolean and), | (boolean or), xor (exactly or), ! (not), any (any true), all (all true)
#
#
# mutate() 
mutate(storms, ratio = pressure / wind)
# Another way to do the above
storms %>%
  mutate(ratio = pressure / wind)
#
#
# Useful Mutate functions


