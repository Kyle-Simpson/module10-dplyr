#Use "dplyr"
#Install.packages("dplyr")
library(dplyr)


#Load in SwissData from data set from data folder and view it to understand what is in it.
SwissData <- read.csv("SwisData.csv")
AgricultureData <- read.csv("agriculture-50.csv")
View(AgricultureData)

#Add a column (using dpylr) that is the absolute difference between Education and Examination and call it
# Educated.Score
SwissData <- mutate(SwissData, Educated.Score = Education/Examination)
View(SwissData)


#Which area(s) had the largest difference
filter(SwissData, Educated.Score == max(Educated.Score))

#Find which region has the highest percent of men in agriculture and retunr only the
#percent and region name.  Use pipe operators to accomplish this.
filter(SwissData, Agriculture == max(Agriculture)) %>% select(Agriculture, Region)


#Find the average of all infant.mortality rates and create a column (Mortality.Difference)
# showing the difference between a regions mortality rate and the mean. Arrange the dataframe in
# Descending order based on this new column. Use pipe operators.
SwissData <- mutate(SwissData, Mortality.Difference = Infant.Mortality - mean(Infant.Mortality)) %>% arrange(Mortality.Difference)

# Create a new data frame that only is that of regions that have a Infant mortality rate less than the
# mean.  Have this data frame only have the regions name, education and mortality rate.
reg.edu.mort <- filter(SwissData, Mortality.Difference < 0) %>% select(Region, Education, Infant.Mortality)
View(reg.edu.mort)

#Filter one of the columns based on a question that you may have (which regions have a higher
#education rate, etc.) and write that to a csv file
filter(reg.edu.mort, Infant.Mortality == max(Infant.Mortality)) %>% write.csv("Highest Infant Mortality")

# Create a function that can take in two different region names and compare them based on a statistic
# Of your choice (education, Examination, ect.)  print out a statment describing which one is greater
# and return a data frame that holds the selected region and the compared variable.  If your feeling adventurous
# also have your function write to a csv file.
CompareRegionsEducation <- function(region1, region2) {
  region <- filter(data, Region %in% c(region1, region2)) %>%
    filter(Education %>% max(Education)) %>%
    select(Region, Education)
  file.path <- paste("data/", region1, "-versus-", region2, ".csv", sep="")
  write.csv(region, file.path)
  return (region)
}
