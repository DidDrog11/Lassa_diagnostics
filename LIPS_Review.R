library("PRISMAstatement")
library("tidyverse")
library("readxl")

Embase_export <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 1, range = cell_cols("B:N"))
Ovid_export <-readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 2, range = cell_cols("B:N"))
WOK_export <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 3, range = cell_cols("B:N"))
Theses_export <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 4, range = cell_cols("B:N"))
Deduplication <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 5, range = cell_cols("B:N"))
Title_screen <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 6, range = cell_cols("B:N"))
Abstract_screen <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 7, range = cell_cols("B:I"))
Full_text <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 8, range = cell_cols("B:I"))
All_author_abstract <- readxl::read_excel(path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Endnote_export.xlsx", sheet = 11, range = cell_cols("B:Q"))

Included_abstracts <- as.data.frame(subset(All_author_abstract, (grepl("Included", All_author_abstract$notes)|
                                                                   grepl("Maybe", All_author_abstract$notes))))

# David selections --------------------------------------------------------
Included_abstracts$David <- 1:104
David_include <- grepl('\"David\"=>\"Included\"', Included_abstracts$notes)
David_maybe <- grepl('\"David\"=>\"Maybe\"', Included_abstracts$notes)
David_exclude <- grepl('\"David\"=>\"Excluded\"', Included_abstracts$notes)
Included_abstracts$David <- Reduce('|', list(David_include, David_maybe, David_exclude))
for (i in 1:104) {
  if (David_include[i] == T) {
    Included_abstracts$David[i] <- "Include"
  } else {
  if (David_maybe[i] == T) {
    Included_abstracts$David[i] <- "Maybe"
  } else {
    if (David_exclude[i] == T) {
    Included_abstracts$David[i] <- "Exclude"
    }}}
}


# Najmul selections -------------------------------------------------------
Included_abstracts$Najmul <-  1:104
Najmul_include <- grepl('\"nhaider\"=>\"Included\"', Included_abstracts$notes)
Najmul_maybe <- grepl('\"nhaider\"=>\"Maybe\"', Included_abstracts$notes)
Najmul_exclude <- grepl('\"nhaider\"=>\"Excluded\"', Included_abstracts$notes)
Included_abstracts$Najmul <- Reduce('|', list(Najmul_include, Najmul_maybe, Najmul_exclude))
for (i in 1:104) {
  if (Najmul_include[i] == T) {
    Included_abstracts$Najmul[i] <- "Include"
  } else {
    if (Najmul_maybe[i] == T) {
      Included_abstracts$Najmul[i] <- "Maybe"
    } else {
      if (Najmul_exclude[i] == T) {
        Included_abstracts$Najmul[i] <- "Exclude"
      }}}
}

# Lia selections ----------------------------------------------------------
Included_abstracts$Lia <-  1:104
Lia_include <- grepl('\"l.arruda\"=>\"Included\"', Included_abstracts$notes)
Lia_maybe <- grepl('\"l.arruda\"=>\"Maybe\"', Included_abstracts$notes)
Lia_exclude <- grepl('\"l.arruda\"=>\"Excluded\"', Included_abstracts$notes)
Included_abstracts$Lia <- Reduce('|', list(Lia_include, Lia_maybe, Lia_exclude))
for (i in 1:104) {
  if (Lia_include[i] == T) {
    Included_abstracts$Lia[i] <- "Include"
  } else {
    if (Lia_maybe[i] == T) {
      Included_abstracts$Lia[i] <- "Maybe"
    } else {
      if (Lia_exclude[i] == T) {
        Included_abstracts$Lia[i] <- "Exclude"
      }}}
}


# Combining selections ----------------------------------------------------
Included_abstracts$Agreement <- c(0)
for (i in 1:104) {
  if (Included_abstracts$David[i] == "Include" && Included_abstracts$Najmul[i] == "Include" && Included_abstracts$Lia[i] == "Include"){
    Included_abstracts$Agreement[i] <- 3
  } else {
    if (Included_abstracts$David[i] == "Include" | Included_abstracts$Najmul[i] == "Include" | Included_abstracts$Lia[i] == "Include"){
      Included_abstracts$Agreement[i] <- ">1"
    }
  }
}

table(Included_abstracts$Agreement)
Full_text_screen <- subset(Included_abstracts[,c(1:2,5,10,15,17:20)], (Included_abstracts$Agreement == 3 | Included_abstracts$Agreement == ">1"))
Need_screen <- as.data.frame(setdiff(Full_text_screen$title, Full_text$title))

write_csv(Full_text_screen, path = "/Users/david/Google Drive/PhD/LIPS Review/Search/Full_text_export.csv")

# PRISMA ------------------------------------------------------------------
tot <- 3028
dedup <- as.integer(count(Embase_export)+count(Ovid_export)+count(WOK_export)+count(Theses_export))
full <- as.integer(count(Full_text))
full_ex <- 13

prisma(found = tot, found_other = 0, no_dupes = dedup, screened = dedup, screen_exclusions = (dedup-full), full_text =  full, full_text_exclusions = full_ex, qualitative = (full-full_ex))
ggplot(Full_text, aes(x = year))+
  geom_bar()+
  theme_classic()+
  xlab("Publication year")+
  ylab("Number of publications")+
  xlim(1970,2020)+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 3))

##Assays
assays <- data.frame(Viral_culture, IFA, ELISA_antigen, ELISA_antibody, RT_PCR)
column_names <- c("Assay Type","Assay name", "Assay abbreviation", "Assay detection method", "Isolation precautions (laboratory category)",
                  "Cross-species", "Validated in animals", "Reported sensitivity/specificity", "Open source", "Ease of use",
                  "Infrastructure demand", "Acute infection or Seropositivity")
Viral_culture <- c("Direct detection", "Viral culture or Plaque Reduction Nutralisation Test", "VC/PRNT", "Visual observation", "Live Virus (BSL4)",
                   "Species independent", "'Gold Standard'", "N/A", "Yes", "Isolation precautions and infrastructure required", "High", "Acute infection")
IFA <- c("Indirect detection","Immunoflourescence assay", "IFA", "Antibody detection IgA or IgG", "BSL3",
         "Yes", "Yes", "?", "Yes", "Specialist test", "Medium", "Acute infection and Seropositivity")
ELISA_antigen <- c("Indirect detection", "Enzyme Linked Immunosorbance Assay-Antigen", "ELISA-Ag", "Direct antigen", "Inactivated virus (BSL3)",
                   "Species independent", "No", "Yes", "No (Proprietary)", "Routine following training", "Medium", "Acute infection")
ELISA_antibody <- c("Indirect detection","Enzyme Linked Immunosorbance Assay-Antibody", "ELISA-Ab", "Indirect antibody", "Antibody based (BSL1?)",
                    "No", "Yes", "Yes", "Yes", "Routine following training", "Medium", "Seropositivity")
RT_PCR <- c("Direct detection", "Reverse-transcriptase Polymerase Chain Reaction", "RT-PCR", "Direct viral RNA", "Inactivated virus (BSL3)",
            "Species independent", "Yes", "Yes", "Yes", "Routine following training", "High", "Acute infection")

rownames(assays) <- column_names

assays <- t(assays)
