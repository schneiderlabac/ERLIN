Comprehensive PMBB Analysis Using SPSS and R for ERLIN1

Overview
This repository contains an SPSS script designed for a detailed statistical analysis of PMBB hepatological data. The script is structured to facilitate a comprehensive exploration of variables related to liver health, including demographic factors, biochemical markers, and disease outcomes. It is intended for researchers and clinicians specializing in hepatology, providing a robust framework for analyzing data related to liver diseases .

Recruitment of the cohorts
The PMBB cohort initially consisted of 61,056 participants. The following participants were subsequently excluded from this study: 1,214 with Chronic viral hepatitis; 19,202 with invalid genotyping and 155 participants with alcohol-related conditions like Alcoholic hepatic failure, Alcoholic cirrhosis, or Alcoholic hepatitis. A total of 4,566 additional participants were excluded because they were TM6SF2 p.Glu167Lys carriers. Additionally, the following diseases were also considered as exclusion criteria: Autoimmune hepatitis (n= 86), Hemochromatosis (n=47), Wilson’s disease (n=12), and Alpha-1 antitrypsin deficiency (n=29). Of the remaining 35,745 participants, 3068 participants without BMI information, 3 participants with incorrect BMI information, and 109 female participants with BMI≥55 kg/m2 (ERLIN1 p.Ile291Val non-carriers only) were excluded. Subsequently, propensity score matching was performed and resulted in a PMBB cohort size of 24,155 participants.

The SPSS script provided for analysis uses a variety of variables related to patient demographics, biochemical markers, liver health indicators, and disease outcomes. Here's a comprehensive list of all the variables mentioned in the code:

Demographic and Basic Health Variables
- `Age_at_Enrollment`: Age of the participants at the time of enrollment in the study.
- `BMI`: Body Mass Index, a key indicator of body fat based on height and weight.
- `sex`: Biological sex of the participants.

 Biochemical Markers and Liver Health Indicators
- `ALT`: Alanine Aminotransferase, a liver enzyme.
- `AST`: Aspartate Aminotransferase, another liver enzyme.
- `Dbili`: Direct Bilirubin, a compound produced by the liver.
- `Alkphos`: Alkaline Phosphatase, an enzyme related to the bile ducts in the liver.
- `Triglycerides`: A type of fat (lipid) found in your blood.
- `HDL`: High-Density Lipoprotein, often referred to as "good" cholesterol.
- `LDL`: Low-Density Lipoprotein, often referred to as "bad" cholesterol.
- `TotalCholesterol`: The total amount of cholesterol in the blood.
- `RandomGlucose`: Blood glucose level at a random time of day.
- `HbA1c_mmolmol`: Hemoglobin A1c, a measure of average blood glucose over the past 3 months.
- `liver_fat`: A variable indicating the amount of fat present in the liver by CT scan.

 Disease and Condition Indicators
- `Diabetes_mellitus_typ2`: Type 2 Diabetes Mellitus status.
- `NAFLD`: Non-Alcoholic Fatty Liver Disease status (K76.0).
- `NASH`: Non-Alcoholic Steatohepatitis status (K75.8).
- `biopsyprovensteatosis`: Status of steatosis confirmed by biopsy.
- `Gestorben`: Mortality status (“deceased").
- `K7_gestorben`: Liver-related death
- `Gestorben_Cardiovascular`: Cardiovascular-related mortality status.
- `k71`, `k72`, `k73`, `k74`, `k75`, `k76`: ICD10-coded liver diseases
- `Survival alle`: Survival time after baseline. The data collection process of the UBK is ongoing. The mortality data used in this study are from October 2021.


Other Variables
- `@10100152307TC_C`: A categorical variable used for grouping or stratifying the data by ERLIN1 genotype.
- `ERLIN01`, `ERLIN02`: Heterozygous or homozygous vs. non-carriers.
- `PC1` to `PC10`: Principal components, likely derived from a principal component analysis (PCA) to reduce dimensionality or to identify patterns in the dataset.
- `MASLD_final`: A variable indicating a final outcome or diagnosis related to liver disease, the specifics of which would require additional context. Patients were diagnosed with MASLD if they had SLD (K76.0) and at least one additional cardiometabolic risk factor: BMI ≥30kg/m2, Diabetes mellitus type 2 (ICD E11) and HbA1c ≥5.7%, essential (primary) hypertension (ICD I10), plasma TG ≥150mg/dl, and HDL ≤50mg/dl (women)/ ≤40mg/dl (men).
- `Statine_R`: Intake of statin medication

These variables are used throughout the script to perform various statistical analyses, including descriptive statistics, t-tests, crosstabulations, linear and logistic regression, and survival analysis. 

Description
PMBB.R describes the dataset creation and the propensity score matching.
The SPSS script (`PMBB.spss`) encompasses a series of statistical procedures aimed at understanding the distribution of key variables, comparing groups, identifying associations, and predicting outcomes related to liver health. The analysis pipeline is divided into several sections, each serving a specific purpose:

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

