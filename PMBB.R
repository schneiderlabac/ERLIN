#load datasets
library(broom)
library(tidyr)
library(dplyr)
library(survival)
library(readr)
library(dplyr)
library(PheWAS)
library(dplyr)
library(reshape2)
library(readr)
library(Matrix)

library(cmprsk)
library(stats)
library(base)
library(ggplot2)
library(tableone)
library(ipw)
library(sandwich)
library(survey)

#import files
pmbb_ndi_cause_of_death <- read.csv("~/Documents/Projekte/Kollaborationen/USA/PMBB/pmbb_ndi_cause_of_death.csv", comment.char="#")
pmbb_onsite_cause_of_death <- read.csv("~/Documents/Projekte/Kollaborationen/USA/PMBB/pmbb_onsite_cause_of_death.csv", comment.char="#")

pmbb_ndi_cause_of_death$DD_yr<-pmbb_ndi_cause_of_death$DD_yr+2000
pmbb_ndi_cause_of_death$DECEASED_DATE <- as.Date(paste(pmbb_ndi_cause_of_death$DD_yr, pmbb_ndi_cause_of_death$DD_mon, pmbb_ndi_cause_of_death$DD_day, sep="-"), format="%Y-%m-%d")

pmbb_cause1<-select(pmbb_ndi_cause_of_death, c(PMBB_ID, CoD_ICD, DECEASED_DATE))
pmbb_cause2<-select(pmbb_onsite_cause_of_death, c(PMBB_ID, CODE, DECEASED_DATE))
pmbb_cause2$DECEASED_DATE <- as.Date(pmbb_cause2$DECEASED_DATE, format="%m/%d/%Y")
pmbb_cause1<-rename(pmbb_cause1, c("CODE"="CoD_ICD"))




pmbb_death_general<-rbind(pmbb_cause1,pmbb_cause2)

pmbb_death_general<- pmbb_death_general[order(pmbb_death_general$CODE), ]
pmbb_death_general<- as.data.frame(pmbb_death_general[!duplicated(pmbb_death_general$PMBB_ID),])
pmbb_death_general$dead<-2

PMBB_Death_Status_date_included_10142022 <- read.csv("~/Documents/Projekte/Kollaborationen/USA/PMBB/PMBB_Death_Status_date_included_10142022.csv")

PMBB_death<-merge(pmbb_death_general, PMBB_Death_Status_date_included_10142022, by="PMBB_ID", all=TRUE)

#select liver death ICD9 (570-573)
pmbb_cause<-rbind(pmbb_cause1,pmbb_cause2)
pmbb_cause_K <- pmbb_cause[grepl("^K7", pmbb_cause$CODE), ]
pmbb_cause_C22 <- pmbb_cause[grepl("^C22", pmbb_cause$CODE), ]
pmbb_cause_Z944 <- pmbb_cause[grepl("^Z94.4", pmbb_cause$CODE), ]
pmbb_cause_B1 <- pmbb_cause[grepl("^B1", pmbb_cause$CODE), ]
pmbb_cause_570 <- pmbb_cause[grepl("^570", pmbb_cause$CODE), ]
pmbb_cause_571 <- pmbb_cause[grepl("^571", pmbb_cause$CODE), ]
pmbb_cause_572 <- pmbb_cause[grepl("^572", pmbb_cause$CODE), ]
pmbb_cause_573 <- pmbb_cause[grepl("^573", pmbb_cause$CODE), ]
pmbb_cause_155 <- pmbb_cause[grepl("^155", pmbb_cause$CODE), ]
pmbb_cause_070 <- pmbb_cause[grepl("^070", pmbb_cause$CODE), ]


Lebertod<-rbind(pmbb_cause_K ,pmbb_cause_C22, pmbb_cause_Z944, pmbb_cause_B1, pmbb_cause_570 , pmbb_cause_571, pmbb_cause_572, pmbb_cause_573, pmbb_cause_155, pmbb_cause_070 )
Lebertod$Lebertod<-1

PMBB_death<-merge(pmbb_death_general, PMBB_Death_Status_date_included_10142022, by="PMBB_ID", all=TRUE)
PMBB_death<-merge(PMBB_death, Lebertod, by="PMBB_ID", all=TRUE)

PMBB_death$dead<-ifelse(PMBB_death$Patient_Status=="Alive",0,PMBB_death$dead)
PMBB_death$dead<-ifelse(PMBB_death$Patient_Status=="Deceased",2,PMBB_death$dead)
PMBB_death<-subset(PMBB_death, dead>=0)
PMBB_death<-as.data.frame(PMBB_death)
PMBB_death$Lebertod[is.na(PMBB_death$Lebertod)] <- PMBB_death$dead[is.na(PMBB_death$Lebertod)]
PMBB_death$Date_Death <- as.Date(PMBB_death$Date_Death, format="%Y-%m-%d")

PMBB_death$DECEASED_DATE <- ifelse(is.na(PMBB_death$DECEASED_DATE.x), PMBB_death$Date_Death, PMBB_death$DECEASED_DATE.x)
PMBB_death$DECEASED_DATE <- as.Date(PMBB_death$DECEASED_DATE, origin = "1970-01-01")

PMBB_death2<-select(PMBB_death, c(PMBB_ID, DECEASED_DATE, Lebertod))

PMBB_death2 <- subset(PMBB_death, is.na(DECEASED_DATE) | as.Date(DECEASED_DATE, "%d/%m/%Y") >= as.Date("2007-03-16"))
PMBB_death2 <- subset(PMBB_death2, is.na(DECEASED_DATE) | as.Date(DECEASED_DATE, "%d/%m/%Y", na.rm = FALSE) <= as.Date("2023-09-30"))

#merge together
PMBB.Release.2020.2.0_phenotype_labs.median.matrix <- read.delim("~/Documents/Projekte/Kollaborationen/USA/PMBB/PMBB-Release-2020-2.0_phenotype_labs-median-matrix.txt")
PMBB_demographics <- read.delim("~/Documents/Projekte/Kollaborationen/USA/PMBB/PMBB-Release-2020-2.1_phenotype_demographics.txt")
PMBB_covariates <- read.delim("~/Documents/Projekte/Kollaborationen/USA/PMBB/PMBB-Release-2020-2.1_phenotype_covariates.txt")
PMBB.Release.2020.2.0_phenotype_icd.10.matrix <- read.delim("~/Documents/Projekte/Kollaborationen/USA/PMBB/PMBB.Release.2020.2.0_phenotype_icd.10.matrix.txt")

PMBB<-merge(PMBB_death2, PMBB.Release.2020.2.0_phenotype_labs.median.matrix, by="PMBB_ID", all.y=TRUE)
PMBB<-merge(PMBB, PMBB_demographics, by="PMBB_ID", all=TRUE)
PMBB<-merge(PMBB, PMBB_covariates, by="PMBB_ID", all=TRUE)
PMBB<-merge(PMBB, PMBB.Release.2020.2.0_phenotype_icd.10.matrix, by="PMBB_ID", all=TRUE)

#PMBB_BMI <- read.csv("~/Documents/Projekte/Kollaborationen/USA/PMBB/PMBB-Release-2020-V1.0_phenotype_vitals-BMI.txt", sep="")
PMBB_BMI$ENC_DATE_SHIFT <- as.Date(PMBB_BMI$ENC_DATE_SHIFT, format="%Y-%m-%d")

PMBB_BMI <- PMBB_BMI %>%
  arrange(desc(ENC_DATE_SHIFT)) %>%
  distinct(PMBB_ID, .keep_all = TRUE)

PMBB<-merge(PMBB, PMBB_BMI, by="PMBB_ID", all=TRUE)

PMBB$DECEASED_DATE<-ifelse(PMBB$Lebertod==0,as.Date("2022-04-30", origin = "1970-01-01"),PMBB$DECEASED_DATE )
PMBB$DECEASED_DATE<-as.Date(PMBB$DECEASED_DATE, origin = "1970-01-01")

PMBB$survival<-as.numeric(difftime(PMBB$DECEASED_DATE,PMBB$BD, units = "days")/365) - PMBB$Age_at_Enrollment
PMBB$Start<-as.Date(as.numeric(PMBB$BD)+PMBB$Age_at_Enrollment, origin = "1970-01-01")

PMBB_final<-subset(PMBB, survival>=0)
PMBB_final<-subset(PMBB, Lebertod>=0)


#add ERLIN1 variant (extractyed using plink) 

PMBB_final<-merge(PMBB_final, ERLIN1, by="PMBB_ID", all=TRUE)

#and add CT derived fat 
PMBB_final<-merge(PMBB_final, CT_fat, by="PMBB_ID", all=TRUE)



#add TM6SF2 variant (extractyed using plink) 

PMBB_final<-merge(PMBB_final, TM6SF2, by="PMBB_ID", all=TRUE)

# propensity score matching

# Load necessary libraries
library(dplyr)
library(MatchIt)

# Step 1: Exclude patients based on initial criteria
PMBB_filtered <- PMBB_final %>%
  filter(!diagnosis %in% c("B18", "K70", "K73", "K72", "K74"), # Excluding chronic viral hepatitis and alcohol-related conditions
         !(genetic_variant == "TM6SF2" & (homozygous == 2 | heterozygous == 1)), # Excluding based on TM6SF2 genetic variant
         !diagnosis %in% c("K75.4", "E83.0", "E83.1", "E88.0"), # Excluding autoimmune hepatitis, Wilson's disease, hemochromatosis, and alpha-1 antitrypsin deficiency
!(BMI >= 55 & genetic_variant == "ERLIN1" & homozygous == 0), # Excluding overweight women non-carriers of ERLIN1 p.Ile291Val
BMI > 8) # Excluding participants with BMI <= 8

# Step 2: Matching based on Propensity Score

# First, calculate Propensity Scores based on age, BMI, sex, and PC1-10

# Propensity score model (hypothetical function)
propensity_model <- function(data) {
  # This is a placeholder for the actual model calculation
}

# Apply the model to calculate scores

PMBB_filtered$propensity_score <- calculate_propensity_scores(
  data = PMBB_filtered,
  treatment = "ERLIN01", 
  covariates = age + BMI + sex + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10
)


# Match non-carriers and heterozygous 1:1, and non-carriers and homozygous 2:1


# Matching for heterozygous
match_data_hetero <- matchit(propensity_score ~ age + BMI + sex + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10,
                             data = PMBB_filtered,
                             method = "nearest",
                             ratio = 1,
                             subset = genetic_variant == "heterozygous")

PMBB_filtered$propensity_score <- calculate_propensity_scores(
  data = PMBB_filtered,
  treatment = "ERLIN02", 
  covariates = age + BMI + sex + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10
)
# Matching for homozygous
match_data_homo <- matchit(propensity_score ~ age + BMI + sex + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10,
                           data = PMBB_filtered,
                           method = "nearest",
                           ratio = 2,
                           subset = genetic_variant == "homozygous")

# Extract matched data
matched_hetero <- match.data(match_data_hetero)
matched_homo <- match.data(match_data_homo)

# Combine matched datasets for analysis
PMBB <- bind_rows(matched_hetero, matched_homo)



