#Importing the Data Set
data <- read.csv("D:/IT VENDANT Data Analysis/R Programming/Project/data.csv")
print(data)

#Check top few rows of the data
head(data)

#Check number of rows and columns in the data
nrow(data)
ncol(data)

#Checking Summary of the data
summary(data)

#Structure of Data 
str(data)


###########################
#Cleaning the Data Set
###########################

#Removing Unnecessary Columns -
#Removing the lattitude and longitude Columns named - X and Y
data <- subset(data, select = -c(X))
data <- subset(data, select = -c(Y))
data <- subset(data,select = -c(Date))
str(data)


#Renaming the columns -
names(data)[names(data) == "PAYS"] <- "Cntry_ab"
names(data)[names(data) == "Code"] <- "Cntry_cd"
names(data)[names(data) == "Ville"] <- "Locality"
#names(data)[names(data) == "End_of_sampling"] <- "End_time"

str(data)


# Check for missing values in each column
missing_values <- colSums(is.na(data))

# Replace missing values with zeros
data[is.na(data)] <- 0

# Print the number of missing values in each column
print(missing_values)



#Modifying the data types
#End_of_Sampling: chr to time
#data$End_of_sampling <- as.POSIXct(data$End_of_sampling, format = "%H:%M")
#I_131_.Bq.m3.  : chr  to int
data$I_131_.Bq.m3. <- as.numeric(data$I_131_.Bq.m3.)
#Cs_134_.Bq.m3. : chr  to int
data$Cs_134_.Bq.m3. <-as.numeric(data$Cs_134_.Bq.m3.)
#Cs_137_.Bq.m3. : chr  to int
data$Cs_137_.Bq.m3. <- as.numeric(data$Cs_137_.Bq.m3.)

str(data)


#Writing it to cleaned file 
write.csv(data, file = "D:/IT VENDANT Data Analysis/R Programming/Project/cleaned_data.csv", row.names = FALSE)


####################################
#VISUALISING THE CLEAN DATA SET
####################################
# Load the ggplot2 package
library(ggplot2)

# Load the cleaned data set
cleaned_data <- read.csv("D:/IT VENDANT Data Analysis/R Programming/Project/cleaned_data.csv")

# Visualize the distribution of the 'Concentration' variable
ggplot(data = cleaned_data, aes(x = I_131_.Bq.m3.)) +
  geom_histogram() +
  xlab("I_131_.Bq.m3.") +
  ylab("Count") +
  ggtitle("Distribution of I_131 Concentration")

# Visualize the relationship between 'Duration' and 'Concentration'
ggplot(data = cleaned_data, aes(x = Duration.h.min., y = I_131_.Bq.m3.)) +
  geom_point() +
  xlab("Duration.h.min") +
  ylab("I_131_.Bq.m3.") +
  ggtitle("Relationship between Duration and Concentration")


# Create a time-series plot of the concentration of Cesium-137 over time
ggplot(cleaned_data, aes(x = Duration.h.min., y = Cs_137_.Bq.m3.)) + 
  geom_line() + 
  xlab("Date") + 
  ylab("Concentration of Cesium-137 (Bq/m3)") +
  ggtitle("Concentration of Cesium-137 over Time")


# Create a time-series plot of the concentration of Cesium-137 over Diffrent Localities
ggplot(cleaned_data, aes(y = Locality, x = Cs_137_.Bq.m3.)) + 
  geom_line() + 
  xlab("Concentration of Cesium-137 (Bq/m3)") + 
  ylab("Locality") +
  ggtitle("concentration of Cesium-137 over timeDiffrent Localities")

