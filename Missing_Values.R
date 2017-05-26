#0: Load the data in RStudio

#load packages

library(readr)
library(dplyr)
library(tidyr)

#Import Dataset
titanic_original <- read_csv("C:/Users/suman/Desktop/titanic_original.csv")
View(titanic_original)

#1 1: Port of embarkation
titanic_original <- titanic_original %>% replace_na(list(embarked = "S"), embarked)

#2 Age

mean_age <- mean(titanic_original$age, na.rm = TRUE)
titanic_original <- titanic_original %>% replace_na(list(age = mean_age), age)

#3 Lifeboat

titanic_original$boat <- gsub("^$","NONE",titanic_original$boat)


#4 Cabin
titanic_original <- titanic_original %>% mutate(has_cabin_number = ifelse(is.na(cabin), 0, 1))

#5 Submit the project on Github

write_csv(titanic_original, "titanic_clean.csv")


