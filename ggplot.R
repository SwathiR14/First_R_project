library(ggplot2)
install.packages("ggplot2")
library(ggplot2)

dat <- read.csv("Data/gapminder_data.csv")


# 1. make a new plot, with nothing in it
ggplot()

# 2. make a new plot, use gapminder data
ggplot(data = dat)

# 3. make a new plot, specify x and y axis
ggplot(data = dat,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))

# 4. specify what shape to draw
ggplot(data = dat,
       mapping = aes(x = gdpPercap,
                     y = lifeExp)) + geom_point()

# 5. scatterplot and line plot
ggplot(data = dat,
       mapping = aes(x = gdpPercap,
                     y = lifeExp)) + geom_point() + geom_line()

# Challenge: plot lifeExp on the y-axis, and year on the x-axis

ggplot(data = dat,
      mapping = aes(x = year,
                    y = lifeExp)) + geom_line()

# 6. to plot by country
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country,
                     color = continent)) + geom_line()

# 7. subplots by country, color coded for each country data point
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country,
                     color = continent)) + geom_line()

# 8. subplots by continent
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country)) + geom_line() + facet_wrap(~ continent)

# 9. to add different scales for different plots
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country)) + geom_line() + facet_wrap(~ continent,
                                                               scales = "free_y")



# 10. same as 9 but with color
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country,
                     color = continent)) + geom_line() + facet_wrap(~ continent,
                                                               scales = "free_y")

# 11. modify axis labels and themes
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country)) + geom_line() + facet_wrap(~ continent,
                                                               scales = "free") + labs(x = "year",
                                                                                       y = "Life Expectancy",
                                                                                       title = "Figure 1") + theme_classic()

#12. to customize appearance and grid lines
ggplot(data = dat,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country,
                     color = continent)) + geom_line() + facet_wrap(~ continent,
                                                               scales = "free") + labs(x = "year",
                                                                                       y = "Life Expectancy",
                                                                                       title = "Figure 1") + theme_classic() + theme(panel.grid = element_line(color = NA))
#13. Save ggplot object into a variable
Figure_1 <- ggplot(data = dat,
                   mapping = aes(x = year,
                                 y = lifeExp,
                                 by = country,
                                 color = continent)) + geom_line() + facet_wrap(~ continent,
                                                                                scales = "free") + labs(x = "year",
                                                                                                        y = "Life Expectancy",
                                                                                                        title = "Figure 1") + theme_classic() + theme(panel.grid = element_line(color = NA))
View(Figure_1)

# 14. To save the plot
ggsave(filename = "Data/Figures/life_Exp.png",
       plot = Figure_1,
       width = 6,
       height = 4,
       units = "in")


# 15. Regression lines
ggplot(data = dat,
       mapping = aes(x = gdpPercap,
                     y = lifeExp)) + geom_point() + scale_x_log10() + scale_y_log10() + geom_smooth(method = "lm")


# 16. fiting a model outside ggplot
model_1 <- lm(lifeExp ~ log(gdpPercap),
              data = dat)

regression_line <- data.frame(gdpPercap = range(dat$gdpPercap))
regression_line <- data.frame(gdpPercap = c(10, 1000))
regression_line <- data.frame(gdpPercap = c(dat$gdpPercap))
regression_line$lifeExp <- predict(model_1,
                                    newdata = regression_line)

ggplot(data = dat,
       mapping = aes(x = gdpPercap,
                     y = lifeExp)) + geom_point() + scale_x_log10() + geom_smooth(method = "lm") + geom_line(data = regression_line,
                                                                                                             mapping = aes(x = gdpPercap,
                                                                                                                           y = lifeExp),
                                                                                                             color = "Orange")
# 17. model statistics
model_1 # object of fitting a linear model
summary(model_1) # the summary of the fitted linear model

model_1_summary <- summary(model_1)
attributes(model_1_summary)

View(summary(model_1))

# 18. Getting values of each statistical attribute

# Get the R^2
# $ is like the callout function

model_1_summary$r.squared
model_1_summary$adj.r.squared

# 19. getting values onto the plot

r_sq <- model_1_summary$r.squared
rsq_title <- paste("R^2 =", round(r_sq, 2))

ggplot(data = dat,
       mapping = aes(x = gdpPercap,
                     y = lifeExp)) + geom_point() + scale_x_log10() + geom_smooth(method = "lm") + geom_line(data = regression_line,
                                                                                                             mapping = aes(x = gdpPercap,
                                                                                                                           y = lifeExp),
                                                                                                             color = "Red") + labs(Title = rsq_title) + geom_text(x = 3, y = 80,
                                                                                                                                                                  label = rsq_title)
