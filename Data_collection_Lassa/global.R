
library(rjson)

fields <- c("Name", "Article_title", "First_author", "Number_species", "Year_data", "Country_data",
            "Number_assay", "Assay_type", "other_assay", "Gold_standard",
            "Animal_species", "Number_samples", "Number_positive", "Number_negative", "Reported_sensitivity", "Reported_specificity",
            "Other comments")
full_text <- read.csv(file = "Full_text_export.csv")
full_text <- full_text[order(full_text$title),]
full_text$authors = as.character(gsub("\\..*","",full_text$authors))
species <- as.character(c("M. cynomolgus", "M. natalensis", "C. mona", "M. mulatta", "R. rattus", "M. erythroleucus",
                          "P. daltoni", "C. sabaeus", "P. rostratus", "Crocidura species", "R. fuscipus", "M. munitoides",
                          "M. mattheyi", "E. patas", "Cercopithecus species", "Other Rodentia species", "Other Non-human primate"))
