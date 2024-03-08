# ERLIN UKB
Description of the code used for the ERLIN1 project
Comprehensive UKB Analysis Using SPSS and R for ERLIN1

Overview
This repository contains an SPSS script designed for a detailed statistical analysis of UKB hepatological data. The script is structured to facilitate a comprehensive exploration of variables related to liver health, including demographic factors, biochemical markers, and disease outcomes. It is intended for researchers and clinicians specializing in hepatology, providing a robust framework for analyzing data related to liver diseases .

Recruitment of the cohorts
The original UKB dataset consisted of 502,511 participants. However, 4,490 participants were excluded due to self-reported pathological alcohol consumption (>60g alcohol/day for men or >40g alcohol/day for women), and an additional 792 participants were excluded due to chronic viral hepatitis (ICD B18). After excluding participants with missing ethnicity information and invalid genotyping, the resulting cohort sizes are as follows: Ethnicity white n= 453, 438; Ethnicity Asian: n=10,832; Ethnicity Black/Black British: n=7,489; Participants with pathological alcohol consumption: n=4,282. Genotyping of the white UKB study cohort yielded in total 227,062 heterozygous and 112,529 homozygous ERLIN1 p.Ile291Val carriers. We split the same study cohort in TM6SF2 p.Glu167Lys non-carriers (n=386,942,), heterozygous (n=62,833), and homozygous carriers (n=2,485). Separate analyses were conducted in an obese cohort based on the white UKB dataset (n=109,172). Participants were classified as obese if their BMI was ≥30kg/m2. Moreover, we performed a gene burden analysis in the white UKB dataset that included an overall of 47 participants carrying ERLIN1 predicted loss-of-function (pLoF) variants. The reference group for this analysis consisted of 200,559 pLoF non-carriers. For 105,348 UKB participants, lipidomic parameters measured by NMR were available and we analyzed the changes of the parameters per ERLIN1 p.Ile291Val and per TM6SF2 p.Glu167Lys allele.

The SPSS script provided for analysis uses a variety of variables related to patient demographics, biochemical markers, liver health indicators, and disease outcomes. Here's a comprehensive list of all the variables mentioned in the code:

 Demographic and Basic Health Variables
- `Age`: Age of the participants at the time of enrollment in the study.
- `BMI`: Body Mass Index, a key indicator of body fat based on height and weight.
- `Sex.umgekehrt`: Biological sex of the participants.
-  `Ethnicity`: Self-reported ethnicity (white, Asian, Black/ Black British, others)

 Biochemical Markers and Liver Health Indicators
- `ALT.norm`: Alanine Aminotransferase, a liver enzyme, Sex-specific upper limit of normal 
- `AST.norm`: Aspartate Aminotransferase, another liver enzyme, Sex-specific upper limit of normal
- `GGT.norm`: Gamma-glutamyl transferase, an enzyme related to the bile ducts in the liver, Sex-specific upper limit of normal
- `Bili_mgdl`: Total Bilirubin, a compound produced by the liver.
- `AP.norm`: Alkaline Phosphatase, an enzyme related to the bile ducts in the liver.
- `@308300.0`: Sex hormone-binding globulin, protein made by your liver.
- `Triglyceride_mgdl`: A type of fat (lipid) found in your blood.
- `HDL_mgdl`: High-Density Lipoprotein, often referred to as "good" cholesterol.
- `LDL_mgdl`: Low-Density Lipoprotein, often referred to as "bad" cholesterol.
- `Cholesterin_mgdl`: The total amount of cholesterol in the blood.
- `@306300.0`: Apolipoprotein A1: Protein that binds lipids.
- `@306400.0`: Apolipoprotein B: Protein that binds lipids.
- `@307400.0`: Blood glucose level at a random time of day.
- `@307500.0`: HbA1c_mmolmol`: Hemoglobin A1c, a measure of average blood glucose over the past 3 months.

 Disease and Condition Indicators
- ` Timeofdiagnosis_E11 `: Type 2 Diabetes Mellitus status.
- ` K760`: Non-Alcoholic Fatty Liver Disease status (K76.0).
- ` K758`: Non-Alcoholic Steatohepatitis status (K75.8).
- `Liver_Fat`: Liver fat (%)
- `Liverfat_größergleichfünfprozent`: Liver fat ≥5%
- `Allcausemortality`: Mortality status (“deceased").
- `Liverdeath`: Liver-related death
- `Cardiovasculardeath`: Cardiovascular-related mortality status.
- `Timeofdiagnosis_K70-76`: ICD10-coded liver diseases
- `Lebererkrankung gesamt`: The presence of at least one ICD-coded liver disease (K70-76, K760. and/or K75.8), Overall liver disease.
- `Timeofdiagnosis_C22`: Malignant neoplasm of liver and intrahepatic bile ducts (C22)
- `Survival_neu`: Survival time after baseline. The data collection process of the UBK is ongoing. The mortality data used in this study are from November 2021. 


Other Variables
- `rs2862954_C `: A categorical variable used for grouping or stratifying the data by ERLIN1 genotype.
- `ERLIN01`, `ERLIN02`: Heterozygous or homozygous vs. non-carriers.
- `TM6SF2_vollständig`: A categorical variable used for grouping or stratifying the data by TM6SF2 p.Glu167Lys genotype.
- `PNPLA3_vollständig`: A categorical variable used for grouping or stratifying the data by PNPLA3 I148M genotype
- `X19.54173068.T.C_T`: A categorical variable used for grouping or stratifying the data by MBOAT7 rs641738 genotype
- `@220090.1 @220090.2 @220090.3 @220090.4 @220090.5 @220090.6 @220090.7 
 @220090.8 @220090.9 @220090.10 `: Principal components, likely derived from a principal component analysis (PCA) to reduce dimensionality or to identify patterns in the dataset.
- `MASLD_final`: A variable indicating a final outcome or diagnosis related to liver disease, the specifics of which would require additional context. Patients were diagnosed with MASLD if they had SLD (K76.0) and at least one additional cardiometabolic risk factor: BMI ≥30kg/m2, Diabetes mellitus type 2 (ICD E11) and HbA1c ≥5.7%, essential (primary) hypertension (ICD I10), plasma TG ≥150mg/dl, and HDL ≤50mg/dl (women)/ ≤40mg/dl (men).
- `ALD_final`: A variable indicating a final outcome or diagnosis related to liver disease, the specifics of which would require additional context. Patients were diagnosed with ALD if they had self-reported pathological alcohol consumption (>60g/>40g alcohol/ day for men/women), SLD (K76.0) and at least one additional cardiometabolic risk factor: BMI ≥30kg/m2, Diabetes mellitus type 2 (ICD E11) and HbA1c ≥5.7%, essential (primary) hypertension (ICD I10), plasma TG ≥150mg/dl, and HDL ≤50mg/dl (women)/ ≤40mg/dl (men).
- `pLoF_geneburden`. This categorical variable encompasses 47 rare pLoF variants of ERLIN1 for gene burden analysis.
- ` Statin_single`: Intake of statin medication

These variables are used throughout the script to perform various statistical analyses, including descriptive statistics, t-tests, crosstabulations, linear and logistic regression, and survival analysis. 

Description
The SPSS script (`UKB.spss`) encompasses a series of statistical procedures aimed at understanding the distribution of key variables, comparing groups, identifying associations, and predicting outcomes related to liver health. The analysis pipeline is divided into several sections, each serving a specific purpose:

 1. Frequencies and Descriptive Statistics
- Activation and initial exploration of the dataset.
- Calculation of frequencies for categorical variables and descriptive statistics for continuous variables, providing an overview of the data distribution.

 2. Group Comparisons
- T-tests to compare means between groups for variables like age and BMI.
- Crosstabulations with chi-square tests to examine the relationship between categorical variables.

 3. Regression Analyses
- Multiple linear regression to explore associations between various biochemical markers and demographic factors.
- Logistic regression for binary outcomes related to liver diseases and mortality.
- Cox proportional hazards models for survival analysis, assessing the impact of different variables on mortality rates.

 4. Additional Analyses
- Further logistic regression analyses focusing on specific outcomes such as MASLD_final, a key variable related to liver disease diagnosis or outcome.

 Usage
To use this script, you will need SPSS software installed on your computer. Open the script in SPSS and adjust the dataset name and variable names as per your dataset's specifications. The script is commented to guide you through each analysis step, making it adaptable for your specific research needs.

 Acknowledgments
This script was developed as part of a collaborative research effort. We thank all contributors and participants in the study.


