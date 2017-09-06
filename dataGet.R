# dataGet.R
# © MIT, Dr. Clifton Franklund
# September 1, 2017


# Load required libraries -------------------------------------------------
library(tidyverse)
library(googlesheets)


# Run this block to get data from Google ----------------------------------
myGoogleSheet <- gs_title("Core Competency Assessment  (Responses)")
rawData <- myData <- gs_read(ss = myGoogleSheet, ws = "Form Responses 1")
myData <- as.data.frame(rawData)

names(myData)[names(myData) == 'CORE COMPETENCY'] <- 'COMPETENCY'
myData$COMPETENCY <- as.factor(myData$COMPETENCY)
myData$COMPETENCY <- factor(myData$COMPETENCY, levels=rev(levels(myData$COMPETENCY)))

names(myData)[names(myData) == 'STANDARD MEASURE'] <- 'MEASURE'
myData$MEASURE <- as.factor(myData$MEASURE)
myData$MEASURE <- factor(myData$MEASURE, levels=rev(levels(myData$MEASURE)))

write.csv(myData[,c(2,3,6)], file="registrations.csv", row.names = FALSE)


# Run this block to get data from csv file --------------------------------
#myData <- read.csv("registrations.csv")
#myData$COMPETENCY <- factor(myData$COMPETENCY, levels=rev(levels(myData$COMPETENCY)))
#myData$MEASURE <- factor(myData$MEASURE, levels=rev(levels(myData$MEASURE)))


# Plot of registrations by competency -------------------------------------
competencyCounts <- myData %>%
	group_by(COMPETENCY) %>%
	summarise(COUNT=n())

ggplot(competencyCounts, aes(x=COMPETENCY, y=COUNT)) +
	geom_bar(stat = "identity", fill = "Firebrick") +
	theme_classic(base_size = 14) +
	coord_flip()



# Plot of registrations by measure ----------------------------------------
measureCounts <- myData %>%
	group_by(MEASURE) %>%
	summarise(COUNT=n())

ggplot(measureCounts, aes(x=MEASURE, y=COUNT)) +
	geom_bar(stat = "identity", fill = "Firebrick") +
	theme_classic(base_size = 14) +
	coord_flip()

