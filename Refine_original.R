#0: Load the data in RStudio

#Load packages
library(readr)
library(dplyr)
library(tidyr)


#Import Dataset
refine_original <- read_csv("C:/Users/suman/Desktop/refine_original.csv")
View(refine_original)

#1: Clean up brand names
refine_original$company <- gsub("^[p|f].*", "philips", refine_original$company, ignore.case = TRUE)
refine_original$company <- gsub("^a.*", "akzo", refine_original$company, ignore.case = TRUE)
refine_original$company <- gsub("^v.*", "van houten", refine_original$company, ignore.case = TRUE)
refine_original$company <- gsub("^u.*", "unilever", refine_original$company, ignore.case = TRUE)

#2: Separate product code and number
refine_original <- refine_original %>% separate("Product code / number", c("product_code", "product_number"), sep = "-")

#3: Add product categories
refine_original$product_category <- refine_original$product_code
refine_original$product_category <- sub("[p]", "Smartphone", refine_original$product_category) 
refine_original$product_category <- sub("[v]", "TV", refine_original$product_category) 
refine_original$product_category <- sub("[x]", "Laptop", refine_original$product_category) 
refine_original$product_category <- sub("[q]", "Tablet", refine_original$product_category) 

#4: Add full address for geocoding
refine_original <- refine_original %>% unite(full_address, address, city, country, sep = ",")

#5: Create dummy variables for company and product category
refine_original$company_philips <- as.numeric(refine_original$company == "philips")
refine_original$company_azko <- as.numeric(refine_original$company == "akzo")  
refine_original$company_van_houten <- as.numeric(refine_original$company == "van Houten")
refine_original$company_unilever <- as.numeric(refine_original$company == "unilever")

refine_original$product_smartphone <- as.numeric(refine_original$product_category == "Smartphone")
refine_original$product_tv <- as.numeric(refine_original$product_category == "TV")
refine_original$product_laptop <- as.numeric(refine_original$product_category == "Laptop")
refine_original$product_laptop <- as.numeric(refine_original$product_category == "Tablet")

#6: Submit the project on Github
write_csv(refine_original, "refine_clean.csv")



