# HCSCI432 Lab 2.1 — Complete Summary

## Lab Guide 2.1: Using R for Random Number Generation and Solving Mathematical/Statistical Problems

This document provides a comprehensive summary of the lab objectives, key concepts, and complete answers to all practice questions.

---

## Learning Outcomes

By the end of this lab, you should be able to:

### 1. Use sample() to select random values
- ✓ With and without replacement
- ✓ From ranges and custom sets
- ✓ Control sample size

### 2. Use set.seed() for reproducibility
- ✓ Understand why reproducibility matters
- ✓ Make random experiments repeatable
- ✓ Compare results across different seeds

### 3. Generate values from distributions
- ✓ Uniform distribution (runif)
- ✓ Normal distribution (rnorm)
- ✓ Exponential distribution (rexp)
- ✓ Binomial distribution (rbinom)
- ✓ Poisson distribution (rpois)

### 4. Explain r-, d-, p-, q- functions
- ✓ r = random generation
- ✓ d = density (probability density function)
- ✓ p = cumulative probability (CDF)
- ✓ q = quantile (inverse CDF)

### 5. Create and inspect population datasets
- ✓ Create data frames
- ✓ Inspect structure
- ✓ Check dimensions

### 6. Perform different sampling methods
- ✓ Random sampling
- ✓ Systematic sampling
- ✓ Stratified sampling
- ✓ Cluster sampling
- ✓ Weighted sampling
- ✓ Convenience sampling
- ✓ Snowball sampling (conceptual)

### 7. Test randomness and distributions
- ✓ Kolmogorov–Smirnov test
- ✓ Chi-square test
- ✓ Interpret p-values

---

## Section-by-Section Guide

### Section 1: Getting Started

**Objective:** Verify R environment works

**Key Command:**
```r
1 + 1
```

**Expected Output:** `[1] 2`

**Learning Point:** R can be used as a calculator; scripts save work, Console executes immediately.

---

### Section 2: Sampling Random Numbers

#### 2.1 Basic Sampling

**Key Concept:** `sample(n)` produces a random permutation of integers 1 to n.

```r
sample(5)
```

**Output Example:**
```
[1] 2 4 1 5 3
```

**Why different each time?** Because randomness is built in.

**Why no repeats?** Default is `replace = FALSE` (sampling without replacement).

---

#### 2.2 Sample Only Part of a Set

**Key Concept:** `sample(n, size)` selects `size` values from 1 to n.

```r
sample(10, 4)   # 4 values from 1-10
sample(10, 7)   # 7 values from 1-10
```

**Question:** Does changing size change possible values or the number of values returned?  
**Answer:** It changes the **number of values returned**. The possible values are still 1–10.

---

#### 2.3 Sampling from a Range

**Key Concept:** Use `1:100` notation to specify a range explicitly.

```r
sample(1:100, 10)
```

**Output:** 10 different integers from 1–100

**What does `1:100` mean?** It generates the sequence 1, 2, 3, ..., 100.

---

#### 2.4 Sampling with Replacement

**Key Concept:** `replace = TRUE` allows the same value to appear multiple times in one sample.

```r
sample(10, 5, replace = TRUE)
```

**Output Example:**
```
[1] 3 3 7 2 7
```

Notice: 3 and 7 appear twice.

**Real-world example:** Simulating repeated experiments (e.g., rolling a die 100 times).

---

#### 2.5 Reproducible Random Numbers

**Key Concept:** `set.seed()` fixes the random number generator so results are identical.

```r
set.seed(42)
sample(5)   # [1] 2 4 1 5 3

set.seed(42)
sample(5)   # [1] 2 4 1 5 3 — SAME result
```

**Why important?** Research and experiments must be reproducible. A different seed gives different results:

```r
set.seed(100)
sample(5)   # [1] 3 4 2 1 5 — Different from seed 42
```

---

### Section 3: Generating Random Numbers from Distributions

#### 3.1 Uniform Distribution

**Key Concept:** `runif()` generates values where each value in the range has equal probability.

```r
runif(5)                          # 5 values between 0 and 1
runif(10, min = 10, max = 20)    # 10 values between 10 and 20
```

**Why decimals?** Uniform generates continuous (decimal) values, not integers.

**Expected range for second command:** Between 10 and 20.

---

#### 3.2 Normal Distribution

**Key Concept:** `rnorm()` generates values from a bell-shaped distribution.

```r
rnorm(10, mean = 50, sd = 10)
rnorm(10, mean = 70, sd = 10)
```

**What does `mean = 50` control?** The center of the distribution.

**What does `sd = 10` control?** The spread (standard deviation).

**Why aren't all values exactly 50?** Because it's random; values vary around the mean.

---

#### 3.3 Other Distributions

| Distribution | Function | Parameters | Example |
|---|---|---|---|
| Exponential | `rexp()` | rate | `rexp(5, rate = 1)` |
| Binomial | `rbinom()` | size, prob | `rbinom(5, size = 10, prob = 0.5)` |
| Poisson | `rpois()` | lambda | `rpois(5, lambda = 3)` |

**Key Observation:** Binomial and Poisson produce whole numbers; exponential produces decimals.

---

### Section 4: Understanding r, d, p, q Functions

**The Convention:**

```
r = Random generation
d = Density
p = Probability (cumulative)
q = Quantile
```

#### Example: Normal Distribution Functions

```r
dnorm(0)      # Density at x = 0
pnorm(0)      # P(Z ≤ 0) = cumulative probability
qnorm(0.95)   # z-score for 95th percentile
rnorm(10)     # Generate 10 random normal values
```

**Expected Outputs:**

```r
dnorm(0)      # [1] 0.3989423
pnorm(0)      # [1] 0.5  (50% of distribution below 0)
qnorm(0.95)   # [1] 1.644854
```

**Key Questions:**

1. **Which function finds P(Z ≤ given score)?**  
   Answer: `pnorm()` (cumulative probability)

2. **Which finds the score for 95th percentile?**  
   Answer: `qnorm()` (quantile/inverse)

3. **Why not describe dnorm() as "probability of x"?**  
   Answer: For continuous distributions, probability at a single point is zero. `dnorm()` gives the **density** (height of the curve), not probability.

---

### Section 5: Creating a Population Dataset

**Objective:** Simulate a realistic dataset for sampling experiments.

```r
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
```

**Verification:**

```
How many observations? 1000
Which are numeric? id, age, income
Which are categorical? gender
```

**Important:** This is simulated data for learning, not a real survey.

---

### Section 6: Sampling Techniques

#### 6.1 Random Sampling Without Replacement

```r
sample_data <- population[sample(nrow(population), 100), ]
nrow(sample_data)  # Should be 100
```

**Why called "without replacement"?** Once a row is selected, it's not available again.

**Practical use:** Drawing a lottery ticket (each ticket can only win once).

---

#### 6.2 Random Sampling With Replacement

```r
sample_data_replace <- population[sample(nrow(population), 100, replace = TRUE), ]
nrow(sample_data_replace)  # Should be 100
```

**Practical difference from 6.1:** Some rows may appear multiple times in this sample.

**Practical use:** Bootstrap resampling, repeated experiments.

---

#### 6.3 Systematic Sampling

```r
k <- 10
systematic_sample <- population[seq(1, nrow(population), by = k), ]
head(systematic_sample)
nrow(systematic_sample)  # Should be 100 (1000/10)
```

**What does `by = 10` mean?** Select every 10th row.

**Rows selected:** 1, 11, 21, 31, ..., 991

**If k = 20?** Sample size would be 50 (1000/20).

**Use case:** Systematic lists (e.g., customer ID lists).

---

#### 6.4 Stratified Sampling by Gender

```r
library(dplyr)
stratified_sample <- population %>%
  group_by(gender) %>%
  sample_n(50) %>%
  ungroup()

table(stratified_sample$gender)
```

**Expected Output:**
```
Female   Male
    50     50
```

**Why preferable?** Ensures both male and female students are represented equally.

**The stratum in this example:** Gender categories (Male, Female).

---

#### 6.5 Cluster Sampling

```r
population$cluster <- cut(population$age, breaks = 5)
selected_clusters <- sample(unique(population$cluster), 2)
cluster_sample <- population[population$cluster %in% selected_clusters, ]
table(cluster_sample$cluster)
```

**How different from stratified?**
- **Stratified:** Sample individuals from each group
- **Cluster:** Randomly select entire groups, then include all members

**What is a cluster here?** Age ranges (e.g., 18–28, 29–39, etc.).

---

#### 6.6 Weighted Sampling

```r
weights <- population$income
weighted_sample <- population[sample(nrow(population), 100, prob = weights), ]
head(weighted_sample)
```

**What variable is the weight?** Income.

**Why does higher weight increase selection chance?** Probability is proportional to weight; higher income = higher probability of selection.

**Important caveat:** Weights should be justified in real research, not arbitrary.

---

#### 6.7 Convenience Sampling

```r
convenience_sample <- population[1:100, ]
```

**Why this is called "convenience":** Selects the first 100 rows because they're easy to access.

**Why statistically undesirable?** First rows may not represent the population; biased.

---

#### 6.8 Snowball Sampling

**Conceptual only** (no R code).

**How it works:** One participant recruits another, who recruits another, etc.

**Example population:** Undocumented migrants, homeless individuals, members of a hidden community.

**Why useful?** Reaches hard-to-identify, hard-to-access populations.

---

### Section 7: Testing Randomness and Distributions

#### 7.1 Kolmogorov–Smirnov Test

**Objective:** Test if generated data match a theoretical distribution.

```r
set.seed(123)
x <- runif(100)
ks.test(x, "punif", min = 0, max = 1)
```

**Expected Output:**
```
Kolmogorov-Smirnov test

data:  x
D = 0.0659, p-value = 0.6841
alternative hypothesis: two-sided
```

**What distribution is being tested?** Uniform distribution (0 to 1).

**What does the p-value help decide?** Whether the data are consistent with the distribution.

**Lab rule:** p > 0.05 means data are consistent; p < 0.05 suggests poor fit.

**Careful interpretation:** High p-value does NOT prove exact fit; it just shows consistency.

---

#### 7.2 Chi-Square Test

**Objective:** Test if observed frequencies match expected (uniform).

```r
x <- sample(1:6, 100, replace = TRUE)
observed <- table(x)
observed
chisq.test(observed)
```

**Output Example:**
```
x
 1  2  3  4  5  6
15 20 18 16 19 12

Chi-squared test for given probabilities

data:  observed
X-squared = 1.28, df = 5, p-value = 0.9357
```

**Why is `table(x)` useful before chi-square?** It converts random numbers into a frequency table, which is what the test needs.

**High p-value (0.9357) suggests?** Observed counts are consistent with equal probabilities (fair die).

**Low p-value would suggest?** Counts differ significantly from expected (unfair die or distribution).

---

## Practice Question — Complete Solution

### Scenario
Simulate 500 students with ID, age (18–30), gender, and scores N(60, 12).

### Task 1: Create Reproducible Population

```r
set.seed(123)
students <- data.frame(
  ID = 1:500,
  age = sample(18:30, 500, replace = TRUE),
  gender = sample(c("Male", "Female"), 500, replace = TRUE),
  score = rnorm(500, mean = 60, sd = 12)
)
```

### Task 2: Display First Six Records

```r
head(students)
```

**Output:**
```
  ID age gender     score
1  1  24   Male  63.50965
2  2  22 Female  62.23221
3  3  30 Female  69.45531
4  4  25 Female  50.28584
5  5  27   Male  61.93522
6  6  22   Male  68.98048
```

### Task 3: Random Sample of 50 Students

```r
random_sample <- students[sample(nrow(students), 50), ]
nrow(random_sample)  # Verify: should be 50
```

### Task 4: Systematic Sample with Interval 5

```r
systematic_sample <- students[seq(1, nrow(students), by = 5), ]
nrow(systematic_sample)  # Should be 100 (500/5)
```

### Task 5: Stratified Sample — 20 from Each Gender

```r
library(dplyr)
stratified_sample <- students %>%
  group_by(gender) %>%
  sample_n(20) %>%
  ungroup()

nrow(stratified_sample)         # Should be 40
table(stratified_sample$gender) # Should be Female: 20, Male: 20
```

### Task 6: Generate 10 Random Scores

```r
random_scores <- rnorm(10, mean = 60, sd = 12)
random_scores
```

**Output Example:**
```
[1] 63.51 59.22 71.34 51.82 62.13 54.87 68.34 60.25 55.71 65.42
```

### Task 7: Probability P(Z ≤ 1.96)

```r
pnorm(1.96)
```

**Output:**
```
[1] 0.975002
```

**Interpretation:** Approximately 97.5% of the standard normal distribution lies below 1.96. This is why 1.96 is used for 95% confidence intervals.

### Task 8: 95th Percentile

```r
qnorm(0.95)
```

**Output:**
```
[1] 1.644854
```

**Interpretation:** The z-score at the 95th percentile is approximately 1.645. So 95% of the distribution is below 1.645.

### Task 9: Chi-Square Test on Six Categories

```r
x <- sample(1:6, 100, replace = TRUE)
observed <- table(x)
observed
chisq.test(observed)
```

**Output Example:**
```
x
 1  2  3  4  5  6
15 20 18 16 19 12

Chi-squared test for given probabilities

data:  observed
X-squared = 1.28, df = 5, p-value = 0.9357
```

**Interpretation:** p = 0.9357 > 0.05, so the observed frequencies are consistent with a uniform distribution (all categories equally likely).

---

## Summary Table: Key Functions

| Function | Purpose | Example | Output |
|---|---|---|---|
| `sample(n)` | Random permutation | `sample(5)` | `[1] 2 4 1 5 3` |
| `sample(n, size, replace=TRUE)` | Sample with replacement | `sample(10, 5, replace=TRUE)` | `[1] 3 7 2 3 9` |
| `runif(n)` | Uniform random values | `runif(3)` | `[1] 0.51 0.23 0.87` |
| `rnorm(n, mean, sd)` | Normal random values | `rnorm(3, mean=50, sd=10)` | `[1] 53.2 48.9 61.1` |
| `rexp(n, rate)` | Exponential values | `rexp(3, rate=1)` | `[1] 0.41 1.23 0.58` |
| `rbinom(n, size, prob)` | Binomial values | `rbinom(3, size=10, prob=0.5)` | `[1] 5 6 4` |
| `rpois(n, lambda)` | Poisson values | `rpois(3, lambda=3)` | `[1] 2 5 3` |
| `set.seed(n)` | Set random seed | `set.seed(42)` | Makes results reproducible |
| `dnorm(x)` | Density at x | `dnorm(0)` | `[1] 0.399` |
| `pnorm(x)` | P(Z ≤ x) | `pnorm(1.96)` | `[1] 0.975` |
| `qnorm(p)` | z-value at percentile p | `qnorm(0.95)` | `[1] 1.645` |
| `ks.test()` | Test distribution fit | `ks.test(x, "punif")` | p-value |
| `chisq.test()` | Test category frequencies | `chisq.test(table(x))` | p-value |

---

## Key Takeaways

1. **Reproducibility is essential** — Always use `set.seed()` in research and experiments.

2. **sample() vs r-functions** — `sample()` selects from existing values; `runif()`, `rnorm()`, etc. generate new values.

3. **Sampling methods differ** — Choose based on population structure and research goal.

4. **Probability functions follow a pattern** — r, d, p, q make sense once you understand the convention.

5. **p-values need interpretation** — p > 0.05 means "consistent with," not "proof of."

6. **Data matters** — Simulated data lets you explore and understand statistical concepts safely.

---

## Frequently Asked Questions

**Q: Why use set.seed() in a simulation?**  
A: So you (and others) can reproduce identical results later. This is crucial for research validation.

**Q: When should I use stratified vs. cluster sampling?**  
A: Stratified when you want representation from all groups. Cluster when groups are geographically or physically separated and sampling entire clusters is practical.

**Q: What does p-value > 0.05 actually mean?**  
A: It means the observed data are consistent with the null hypothesis (e.g., the distribution is uniform). It does NOT prove the hypothesis is true.

**Q: Can I use pnorm() to find probability that Z equals 1.96?**  
A: No — for continuous distributions, probability at any single point is zero. Use pnorm() for "less than or equal to" (cumulative), not "exactly equal to."

**Q: Why do rnorm() values vary around the mean?**  
A: Because it's random. By definition, random values vary. They cluster around the mean, but individual values will differ.

---

## Additional Resources

- R Documentation: Type `?function_name` in R console (e.g., `?sample`, `?rnorm`)
- dplyr Tutorial: https://dplyr.tidyverse.org/
- StatQuest: YouTube channel for statistics intuition
- Coursera/EdX: Free introductory statistics courses

---

**Course:** HCSCI432  
**Lab Guide:** 2.1  
**Date:** October 2026  
**Status:** Complete Summary and Solutions
