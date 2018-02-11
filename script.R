#I plan on exploring the Lahman dataset to analyze the Brewers 
#1980's World Series team (I forget which year specifically) vs the most recent team in the Lahman database.

install.packages("tidyverse")
install.packages("Lahman")

library("tidyverse")
library("Lahman")

#Need to find preliminary information out. How is Milwaukee Brewers determined? WHich year
#did they win the World Series? 
TeamsFranchises
#Running TeamsFranchises shows the list of franchise information. The Brewers are indicated by MIL
MIL_Teams <- Teams %>%
  filter(franchID=="MIL" & yearID>1980)

MIL_Teams
#Unfortunately, the teamID of MIL and over 1980 start in year 1998. Need to now figure out what happened to less than 1998
#Reverted MIL_Teams to utilize the franchID variable instead. Apparently the teamID was ML4 in the 80's. 
#Identified this by filtering the teams database to just the 80's and looking through the data

Teams_80s <- Teams %>%
  filter(yearID>1980)
Teams_80s

filter(MIL_Teams, LgWin=="Y")
#Filtering for LgWin of Y shows us the year they went to the world series was 1982.
#Most recent year of data in Lahman in 2016.

BrewCrew2016 <- Teams %>%
  filter(franchID=="MIL" & yearID==2016)

BrewCrew1982 <- Teams %>%
  filter(franchID=="MIL" & yearID==1982)

#initial view shows 1982 team had 163 games vs 162 games for the 2016 team.
#Actually I could probably use the %in%, rather than have two data tables

BrewCrewCompare<- Teams %>%
  filter(franchID=="MIL" & yearID %in% c(1982, 2016))

#To now compute some per game metrics to compare data across years
BrewCrewCompare %>%
  mutate(HPG=H/G, 
         RPG=R/G,
         X2BPG=X2B/G,
         X3BPG=X3B/G,
         HRPG=HR/G,
         ERPG=ER/G,
         HAPG=HA/G,
         HRAPG=HRA/G,
         EPG=E/G,
         HRAperHA=HRA/HA)

#Just a quick glance through the tables shows:
# 1.) HPG up nearly 2 hits in 1982
# 2.) RPG up 1.3 runs in 1982
# 3.) Most offensive metrics up in 1982 (H, R, 2B, 3B, HR)
# 4.) Earned Runs are nearly flat (649 vs 650 in total)
# 5.) However, that ER in 1982 resulted from a heavier percentage of hits that were not HR
#   a.) HAPG is up by 64 in 1982
#   b.) HRAPG is down by 26 HRA in total