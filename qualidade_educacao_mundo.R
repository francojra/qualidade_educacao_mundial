
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

### PISA tests the students in three different dimensions, 
### which they define as follows:

# - “Science literacy is defined as the ability to engage with 
# science-related issues, and with the ideas of science, as a 
# reflective citizen. A scientifically literate person is willing 
# to engage in reasoned discourse about science and technology, 
# which requires the competencies to explain phenomena scientifically,
# evaluate and design scientific enquiry, and interpret data and 
# evidence scientifically.

# - Reading literacy is defined as students’ ability to understand, 
# use, reflect on and engage with written texts in order to achieve 
# one’s goals, develop one’s knowledge and potential, and participate 
# in society.

# - Mathematical literacy is defined as students’ capacity to 
# formulate, employ and interpret mathematics in a variety of 
# contexts. It includes reasoning mathematically and using 
# mathematical concepts, procedures, facts and tools to describe, 
# explain and predict phenomena. It assists individuals in 
# recognising the role that mathematics plays in the world and to 
# make the well-founded judgements and decisions needed by 
# constructive, engaged and reflective citizens.”

# Pacotes necessários para as análises -----------------------------------------------------------------------------------------------------

library(tidyverse)
library(RColorBrewer)

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

qe <- read.csv("pisa-test-score-mean-performance-on-the-reading-scale.csv") 
view(qe)
names(qe)

# Manipular dados --------------------------------------------------------------------------------------------------------------------------

qe1 <- qe %>%
  select(Entity, Year, PISA..Mean.performance.on.the.reading.scale) %>%
  rename(performance_leitura = PISA..Mean.performance.on.the.reading.scale) %>%
  filter(Entity %in% c("United States", "Canada", "Mexico",
                       "Brazil", "Colombia", "Peru",
                       "Argentina", "Chile", "Uruguai",
                       "Australia", "Russia", "China")) %>%
  view()

qe2 <- qe1 %>%
  group_by(Entity) %>%
  summarise(media = mean(performance_leitura),
            sd = sd(performance_leitura),
            n = n(), se = sd/sqrt(n)) %>%
  view()

qe3 <- qe %>%
  select(Entity, Year, PISA..Mean.performance.on.the.reading.scale) %>%
  rename(performance_leitura = PISA..Mean.performance.on.the.reading.scale) %>%
  filter(Entity %in% c("United States", "Canada", "Mexico",
                       "Brazil", "Colombia", "Peru",
                       "Argentina", "Chile", "Uruguai",
                       "Australia", "Russia", "China"),
         Year == "2015") %>%
  view()

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

ggplot(qe2, aes(x = fct_reorder(Entity, media), 
                y = media, fill = Entity)) +
  geom_col() +
  geom_errorbar(aes(x = Entity, y = media,
                ymin = media - se, ymax = media + se),
                size = 0.85, width = 0.3) +
  scale_fill_brewer(palette = "Paired") +
  coord_flip() +
  labs(y = "Pontuação na Performance de Leitura",
       x = "Países",
       title = "PISA Test Score entre 2000 e 2015") +
  theme(legend.position = "none",
        axis.title = element_text(size = 12),
        axis.text = element_text(colour = "black"))

ggplot(qe3, aes(x = fct_reorder(Entity, performance_leitura), 
                y = performance_leitura, 
                fill = Entity)) +
  geom_col() +
  scale_fill_brewer(palette = "Paired") +
  coord_flip() +
  labs(y = "Pontuação na Performance de Leitura",
       x = "Países",
       title = "PISA Test Score em 2015") +
  theme(legend.position = "none",
        axis.title = element_text(size = 12),
        axis.text = element_text(colour = "black"))

qe1$Year <- as.factor(qe1$Year)

ggplot(qe1, aes(x = Year, 
                y = performance_leitura, 
                group = Entity, color = Entity)) +
  geom_point(size = 3) +
  geom_line(size = 1.6) +
  scale_color_brewer(palette = "Paired") +
  labs(y = "Pontuação na Performance de Leitura",
       x = "Anos",
       color = "Países",
       title = "PISA Test Score") +
  theme(legend.position = "bottom",
        axis.title = element_text(size = 12),
        axis.text = element_text(colour = "black"))
