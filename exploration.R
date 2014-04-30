 
rm(list = ls())

# Data Preprocess ---------------------------------------------------------

setwd("~/Documents/Cornell/ORIE4740/FinalProject//parkinsonsDataMining")
codeList = read.csv("ppmiData/_Study_Docs/Code_List.csv")
dataDictionary = read.csv("ppmiData/_Study_Docs/Data_Dictionary.csv")

striatal_Binding_Ratio_Results = read.csv("ppmiData/Imaging/DaTscan_Striatal_Binding_Ratio_Results.csv")
patient_Status = read.csv("ppmiData//_Subject_Characteristics/Patient_Status.csv")
symbol_Digit_Modalities = read.csv("ppmiData/Non_motor_Assessments/Symbol_Digit_Modalities_Text.csv")

#symbol_Digit_Modalities = read.csv("ppmiData/Non-motor_Assessments")

pd_Data_Frame = striatal_Binding_Ratio_Results

# adding PD status column  -------------------------------------------------

pD_patient_ind = subset(patient_Status, ENROLL_CAT == 'PD')
pD_patient_ind = pD_patient_ind[,1]
number_of_patients = length(levels(as.factor(striatal_Binding_Ratio_Results$PATNO))) #number of 
foo1 = c()

for(i in 1:dim(pd_Data_Frame)[1])
{
  if(pd_Data_Frame[i,1] %in% pD_patient_ind)
  {
    foo1[i] = TRUE #TRUE FOR PD
  }
  else
  {
    foo1[i] = FALSE # FALSE FOR HC
  }
}

# adding symbol digit modalities ------------------------------------------

foo1 = c()
foo2 = c()
for(i in 1:dim(pd_Data_Frame)[1])
{
  if(pd_Data_Frame[i,1] %in% pD_patient_ind)
  {
    foo1[i] = TRUE #TRUE FOR PD
  }
  else
  {
    foo1[i] = FALSE # FALSE FOR HC
  }
}


# calculating the average variance of the caudate variables ---------------
#we need to know this in order to compress the patient data temporally
patients = levels(as.factor(striatal_Binding_Ratio_Results$PATNO)) #unique patient list
caudate_r_variance = c()
caudate_l_variance = c()
putamen_r_variance = c()
putamen_l_variance = c()
for(i in 1:length(patients))
{
  pikachu = subset(striatal_Binding_Ratio_Results, PATNO == patients[i])
  if(dim(pikachu)[1]>1)
  {
    caudate_r_variance[i] = var(pikachu$CAUDATE_R)
    caudate_l_variance[i] = var(pikachu$CAUDATE_L)
    putamen_r_variance[i] = var(pikachu$PUTAMEN_R)
    putamen_l_variance[i] = var(pikachu$PUTAMEN_L)
  }
}
sbr_names = c("caudate_r_variance","caudate_l_variance",
              "putamen_r_variance","putamen_l_variance")
means = c(mean(caudate_r_variance,na.rm=TRUE),
          mean(caudate_l_variance,na.rm=TRUE),
          mean(putamen_r_variance,na.rm=TRUE),
          mean(putamen_l_variance,na.rm=TRUE))

mean_patient_sbr_variance = data.frame(sbr_names,means)

variances = c(var(striatal_Binding_Ratio_Results$CAUDATE_R, na.rm=TRUE),
              var(striatal_Binding_Ratio_Results$CAUDATE_L, na.rm=TRUE),
              var(striatal_Binding_Ratio_Results$PUTAMEN_R, na.rm=TRUE),
              var(striatal_Binding_Ratio_Results$PUTAMEN_L, na.rm=TRUE))

sbr_variance = data.frame(sbr_names,variances)


# Calculating the average, and the average change of the caudate variables -----------------
#patients = levels(as.factor(striatal_Binding_Ratio_Results$PATNO))
caudate.r.avg.diff = c()
caudate.l.avg.diff = c()
putamen.r.avg.diff = c()
putamen.l.avg.diff = c()
caudate.r.avg = c()
caudate.l.avg = c()
putamen.r.avg = c()
putamen.l.avg = c()

for(i in 1:length(patients))
{
  pikachu = subset(striatal_Binding_Ratio_Results, PATNO == patients[i])
  
  #calculating the means
  caudate.r.avg[i] = mean(pikachu$CAUDATE_R)
  caudate.l.avg[i] = mean(pikachu$CAUDATE_L)
  putamen.r.avg[i] = mean(pikachu$PUTAMEN_R)
  putamen.l.avg[i] = mean(pikachu$PUTAMEN_L)
  
  if(dim(pikachu)[1]>1)
  {
    caudate.r.avg.diff[i] = mean(diff(pikachu$CAUDATE_R))
    caudate.l.avg.diff[i] = mean(diff(pikachu$CAUDATE_L))
    putamen.r.avg.diff[i] = mean(diff(pikachu$PUTAMEN_R))
    putamen.l.avg.diff[i] = mean(diff(pikachu$PUTAMEN_L))
    #print(caudate.l.avg.diff[i])
  }
  else
  {
    caudate.r.avg.diff[i] = NA
    caudate.l.avg.diff[i] = NA
    putamen.r.avg.diff[i] = NA
    putamen.l.avg.diff[i] = NA
  }
  
}

sbr.avg = data.frame(patients,
                     caudate.r.avg,caudate.l.avg,
                     putamen.r.avg,putamen.l.avg
                     )

sbr.avg.diff = data.frame(patients,
                          caudate.r.avg.diff,caudate.l.avg.diff,
                          putamen.r.avg.diff,putamen.l.avg.diff
                          )
# plotting pairs ----------------------------------------------------------
pd_Data_Frame[,"PD_STATUS"] = foo1

pd.sbr.meanAndAvgDiff.data = data.frame(patients,
                                        caudate.r.avg,caudate.l.avg,
                                        putamen.r.avg,putamen.l.avg,
                                        caudate.r.avg.diff,caudate.l.avg.diff,
                                        putamen.r.avg.diff,putamen.l.avg.diff
                                        )

# getting the colors ------------------------------------------------------
pd.ind = c()
for(i in 1:dim(pd.sbr.meanAndAvgDiff.data)[1])
{
  if(pd.sbr.meanAndAvgDiff.data[i,1] %in% subset(patient_Status, ENROLL_CAT == 'PD')[,1])
  {
    pd.ind[i] = TRUE #TRUE FOR PD
  }
  else
  {
    pd.ind[i] = FALSE # FALSE FOR HC
  }
}

pd.sbr.meanAndAvgDiff.data[,"pdTRUE"] = pd.ind

cols = character(nrow(pd.sbr.meanAndAvgDiff.data))
cols[ pd.sbr.meanAndAvgDiff.data$pdTRUE == TRUE ] = "blue"
cols[ pd.sbr.meanAndAvgDiff.data$pdTRUE == FALSE ] = "red"

pairs(pd.sbr.meanAndAvgDiff.data,col = cols)

#pc = princomp(pd.sbr.meanAndAvgDiff.data[,c(-1,-10)],na.action = na.omit)

# 


#cols = character(nrow(pd_Data_Frame))
#cols[pd_Data_Frame$PD_STATUS == TRUE ] = "yellow"
#cols[pd_Data_Frame$PD_STATUS == FALSE ] = "green"

# pairs(pd_Data_Frame[,c(-1,-2)],col=cols)      