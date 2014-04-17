 
rm(list = ls())

# Data Preprocess ---------------------------------------------------------

setwd("~/Documents/Cornell/ORIE4740/FinalProject//parkinsonsDataMining")
codeList = read.csv("ppmiData/_Study_Docs/Code_List.csv")
dataDictionary = read.csv("ppmiData/_Study_Docs/Data_Dictionary.csv")
striatal_Binding_Ratio_Results = read.csv("ppmiData/Imaging/DaTscan_Striatal_Binding_Ratio_Results.csv")

head(striatal_Binding_Ratio_Results)

number_of_patients = length(levels(as.factor(striatal_Binding_Ratio_Results$PATNO)))

