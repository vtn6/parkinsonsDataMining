 
rm(list = ls())

# Data Preprocess ---------------------------------------------------------

setwd("~/Documents/Cornell/ORIE4740/FinalProject//parkinsonsDataMining")
codeList = read.csv("ppmiData/_Study_Docs/Code_List.csv")
dataDictionary = read.csv("ppmiData/_Study_Docs/Data_Dictionary.csv")

striatal_Binding_Ratio_Results = read.csv("ppmiData/Imaging/DaTscan_Striatal_Binding_Ratio_Results.csv")
patient_Status = read.csv("ppmiData//_Subject_Characteristics/Patient_Status.csv")

head(striatal_Binding_Ratio_Results)

pD_patient_ind = subset(patient_Status, ENROLL_CAT == 'PD')
pD_patient_ind = pD_patient_ind[,1]

number_of_patients = length(levels(as.factor(striatal_Binding_Ratio_Results$PATNO)))


# adding PD status column to SBR -------------------------------------------------
foo1 = c()
for(i in 1:dim(striatal_Binding_Ratio_Results)[1])
{
  if(striatal_Binding_Ratio_Results[i,1] %in% pD_patient_ind)
  {
    foo1[i] = TRUE #TRUE FOR PD
  }
  else
  {
    foo1[i] = FALSE # FALSE FOR HC
  }
}

striatal_Binding_Ratio_Results[,"PD_STATUS"] = foo1

cols = character(nrow(striatal_Binding_Ratio_Results))
cols[striatal_Binding_Ratio_Results$PD_STATUS == TRUE ] = "yellow"
cols[striatal_Binding_Ratio_Results$PD_STATUS == FALSE ] = "green"

pairs(striatal_Binding_Ratio_Results[,c(-1,-2)],col=cols)      