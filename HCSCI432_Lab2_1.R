# HCSCI432_Lab2_1.R
# Lab Guide 2.1: Using R for Random Number Generation and Solving Mathematical/Statistical Problems

# 1. Getting started in R
1 + 1

# 2. Sampling random numbers using sample()
# 2.1 Basic sampling
sample(5)

# 2.2 Sample only part of a set
sample(10, 4)
sample(10, 4)
sample(10, 7)

# 2.3 Sampling from a range
sample(1:100, 10)

# 2.4 Sampling with replacement
sample(10, 5, replace = TRUE)
sample(10, 10, replace = TRUE)

# 2.5 Reproducible random numbers
set.seed(42)
sample(5)

set.seed(42)
sample(5)

set.seed(100)
sample(5)

# 3. Generating random numbers using probability distributions
# 3.1 Uniform distribution
runif(5)
runif(10, min = 10, max = 20)

# 3.2 Normal distribution
rnorm(10, mean = 50, sd = 10)
rnorm(10, mean = 70, sd = 10)

# 3.3 Other distributions
rexp(5, rate = 1)
rbinom(5, size = 10, prob = 0.5)
rpois(5, lambda = 3)

# 4. Understanding the r, d, p and q convention
dnorm(0)
pnorm(0)
qnorm(0.95)

# 5. Creating a population dataset
set.seed(123)
population <- data.frame(
  id = 1:1000,
  age = sample(18:65, 1000, replace = TRUE),
  gender = sample(c("Male", "Female"), 1000, replace = TRUE),
  income = round(rnorm(1000, mean = 500, sd = 100), 2)
)

head(population)
nrow(population)
names(population)

# 6. Sampling techniques
# 6.1 Random sampling without replacement
sample_data <- population[sample(nrow(population), 100), ]
nrow(sample_data)

# 6.2 Random sampling with replacement
sample_data_replace <- population[sample(nrow(population), 100, replace = TRUE), ]
nrow(sample_data_replace)

# 6.3 Using dplyr
# install.packages("dplyr")
library(dplyr)
sample_data_dplyr <- population %>% sample_n(100)
nrow(sample_data_dplyr)

# 6.4 Systematic sampling
k <- 10
systematic_sample <- population[seq(1, nrow(population), by = k), ]
head(systematic_sample)
nrow(systematic_sample)

# 6.5 Stratified sampling by gender
stratified_sample <- population %>%
  group_by(gender) %>%
  sample_n(50) %>%
  ungroup()

table(stratified_sample$gender)

# 6.6 Cluster sampling
population$cluster <- cut(population$age, breaks = 5)
selected_clusters <- sample(unique(population$cluster), 2)
cluster_sample <- population[population$cluster %in% selected_clusters, ]
table(cluster_sample$cluster)

# 6.7 Weighted sampling
weights <- population$income
weighted_sample <- population[sample(nrow(population), 100, prob = weights), ]
head(weighted_sample)

# 6.8 Convenience sampling
convenience_sample <- population[1:100, ]
head(convenience_sample)

# 7. Testing randomness and distributions
# 7.1 KS test for uniformity
set.seed(123)
x <- runif(100)
ks.test(x, "punif", min = 0, max = 1)

# 7.2 Chi-square test for discrete outcomes
x <- sample(1:6, 100, replace = TRUE)
observed <- table(x)
observed
chisq.test(observed)

# 8. Practice Question
# 8.1 Create reproducible population
set.seed(321)
students <- data.frame(
  ID = 1:500,
  age = sample(18:30, 500, replace = TRUE),
  gender = sample(c("Male", "Female"), 500, replace = TRUE),
  score = rnorm(500, mean = 60, sd = 12)
)

# 8.2 Display first six records
head(students)

# 8.3 Random sample without replacement
random_sample_50 <- students[sample(nrow(students), 50), ]

# 8.4 Systematic sample with interval 5
systematic_sample_5 <- students[seq(1, nrow(students), by = 5), ]

# 8.5 Stratified sample with 20 from each gender
stratified_sample_20 <- students %>%
  group_by(gender) %>%
  sample_n(20) %>%
  ungroup()

# 8.6 Generate 10 random scores from normal distribution
random_scores <- rnorm(10, mean = 60, sd = 12)
random_scores

# 8.7 Probability of a standard normal value being <= 1.96
pnorm(1.96)

# 8.8 Value corresponding to the 95th percentile
qnorm(0.95)

# 8.9 Chi-square test on six equally likely categories
x_practice <- sample(1:6, 100, replace = TRUE)
obs_practice <- table(x_practice)
obs_practice
chisq.test(obs_practice)
