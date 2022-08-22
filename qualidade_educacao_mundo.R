
# Qualidade da Educação no mundo -----------------------------------------------------------------------------------------------------------
# Autora do script: Jeanne Franco ----------------------------------------------------------------------------------------------------------
# Data: 21/08/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://ourworldindata.org/quality-of-education ------------------------------------------------------------------------------

# Sobre o conjunto de dados ----------------------------------------------------------------------------------------------------------------

### The PISA Study

### The Program for International Student Assessment (PISA) 
### assessment, which is coordinated by the OECD, is the most well 
### known international assessment of learning outcomes. The first 
### PISA study was carried out in 1997 and since then it was 
### repeated every three years.

# Pacotes necessários para as análises -----------------------------------------------------------------------------------------------------

library(tidyverse)

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

qe <- read.csv("pisa-test-score-mean-performance-on-the-reading-scale.csv") 
view(qe)
names(qe)

