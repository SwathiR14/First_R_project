library("dplyr")

# read in the gapminder data
dat <- read.csv("Data/gapminder_data.csv")

mean(dat$gdpPercap)

mean(dat[dat$continent == "Americas", "gdpPercap"])


#### using dplyr fr data subsetting ----
filter(dat, continent == "Americas")

select(dat, continent)

filter(dat, year > 2000)


# is the pipe that works same as unix shell
%>% 
  
dat %>% 
  filter (continent == "Americas", year >2000) %>% 
  select (coutry, year, gdpPercap)

sin(log(exp(5)))
# how the pipe works for the above equation
5 %>% 
  exp() %>% 
  log() %>% 
  sin()

#### group_by() and summarize () ----

make groups from data
 summarize does the calculation from the grouped data

 
summary_1 <- dat %>% 
  group_by(country) %>% 
summarise (avg_life_exp = mean(lifeExp))

#### challenge question ----

# 1. average gppercap for each country
#2. gdppercap for each continent in year 1957


#1.

dat %>% 
  group_by(country) %>% 
  summarize(avg_gdppercap = mean(gdpPercap))

#2.

dat %>% 
  filter(year == 1957) %>% 
  group_by(continent) %>% 
  summarize(avg_gdppercap1 = mean(gdpPercap))

#alternate to 2.

dat %>% 
  group_by(continent, year) 
summarize (avggdp = mean(gdpPercap))


#### multiple summary outputs ----

dat %>% 
  group_by(continent) %>% 
  summarize (avg_gdp = mean(gdpPercap)), meadian_gdp = median(gdpper), sd, num_values = n()

#### making new colum variables ----

dat %>% 
  mutate(gdp_billion = gdpPercap * 10^9)


#### wide vs long data in gapminder data ----

dat2 <- dat %>% 
  select(country, year, gdpPercap) %>% 

library(tidyr)
dat2_wide <- dat2 %>% 
  spread(year, gdpPercap)

#spread is for long to wide data presentation
#gather is for wide to long distribution

dat2_long <- dat2_wide %>% 
  gather(year, gdp, "1952":"2000")