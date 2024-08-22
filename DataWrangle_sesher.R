##### Data Wrangle 


## Libarary shit 

# library(dplyr)
# library(tidyverse)
# library(fauxnaif)
# library(summarytools)
# library(psych)
# library(DescTools)
library(MplusAutomation)
library(scales)

## Set working directory 

# file.choose()

setwd("/home/cglab/projects/abcd/data/abcd5.1-rser")


df <- read.csv('abcd5.1_rtmri_2b_epn_cort_subc_net_ders_thrt_demo1_qcr_urg_dep_wide_lf_hsesg_snum.csv', na.strings = c("", "NaN", "nan", "NA"))

### save to dat
# change extreme flags to NA
# df[df > 700] <- NA
# df[df < -700] <- NA
# change threat9 to threatf since ending number thats not a wave is confusing
names(df)[names(df) == 'Threat9'] <- 'Threatf'
# change HSES1 to DEPRV since ending number thats not a wave is confusing
names(df)[names(df) == 'HSES1'] <- 'Deprv'
# change ders_aware_clar_score_7 to Idntify7 to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_aware_clar_score_7'] <- 'Identify'
# change ders__name for ease of reading and to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_nonaccept_score_3_7'] <- 'NonAcpt'
# change to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_goals_score_3_7'] <- 'Goal'
# change to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_impulse_score_3_7'] <- 'Impulse'
# change hses name
names(df)[names(df) == 'HSES1c'] <- 'HSES1'

# change ders_aware_clar_score_9 to Idntify9 to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
# names(df)[names(df) == 'Idntify9'] <- 'ders_aware_clar_score_9'

# quadratic and cubic terms
df$SHSES1SQ <- scale(df$HSES1SQ)
df$SHSES1CB <- scale(df$HSES1CB)
# scale deprivation indicators
df$Sadi_perc_W1 <- scale(df$adi_perc_W1)
df$SPedud1 <- scale(df$Pedud1)
df$SFamDep1 <- scale(df$FamDep1)
df$SPmeg_R_W1 <- scale(df$Pmeg_R_W1)
df$Sempl_R_W1 <- scale(df$empl_R_W1)
df$SIPR1 <- scale(df$IPR1)
df$SLowEdu1 <- scale(df$LowEdu1)
df$SSingPH1 <- scale(df$SingPH1)
df$SUnempR1 <- scale(df$UnempR1)

# scale DERS subscale scores indicators
df$SIdentify <- scale(df$Identify)
df$SNonAcpt <- scale(df$NonAcpt)
df$SGoal <- scale(df$Goal)
df$SImpulse <- scale(df$Impulse)
# reverse income poverty ratio b/c it's reverse loading with other depriv indicators
# possible that the others are reverse coded and need to be reversed back, consider
df$SIPR1r <- df$SIPR1*-1
df$IPR1r <- df$IPR1*-1
# convert to integer and increment by 1 to remove 0 label
df$famID1 <- as.integer(df$famID1+1)
# age in years
# df$agey <- df$age/12
# standardize some variables
df$Spropense <- rescale(df$prpensit1, to=c(0, 1))
df$Spedu <- scale(df$pedu1)
df$Sagey <- scale(df$agey1)
df$Sincome <- scale(df$income1)
df$Srace <- scale(df$race1)
df$SMot <- scale(df$Motrs1)
setwd("/home/cglab/projects/abcd/sesher")
prepareMplusData(df, "ABCD_SESHER_big_7-23-24.dat")

################################
hist(df$HSES1gSQ)
hist(df$SHSES1SQ)
