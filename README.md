# HCSCI432 Lab Guide 2.1: Using R for Random Number Generation

This repository contains the complete practical lab guide, code, and solutions for HCSCI432 Lab Guide 2.1: Using R for Random Number Generation and Solving Mathematical/Statistical Problems.

## Contents

- HCSCI432_Lab2_1.R — Main lab script with all exercises
- HCSCI432_Lab2_1_Solutions.R — Worked solutions with expected outputs
- LAB_SUMMARY.md — Complete summary of objectives, concepts, and answers

## Learning Objectives

By completing this lab, you will be able to:

✓ Use `sample()` to select random values with and without replacement  
✓ Use `set.seed()` to make random results reproducible  
✓ Generate values from uniform, normal, exponential, binomial, and Poisson distributions  
✓ Explain the difference between r-, d-, p-, and q- functions in R  
✓ Create and inspect a simple population dataset  
✓ Perform random, systematic, stratified, cluster, weighted, convenience, and snowball sampling  
✓ Use the Kolmogorov–Smirnov (KS) test and chi-square test to investigate data randomness  

## Quick Start

### 1. Open R or RStudio

```r
# Create a script file named HCSCI432_Lab2_1.R
# Copy commands from HCSCI432_Lab2_1.R and run them step-by-step
```

### 2. Install Required Package

```r
install.packages("dplyr")
```

### 3. Run the Lab

Follow the structure:
- Step — Type and run the command
- Observe — Look carefully at the result
- Explain — Answer the question in your own words
- Checkpoint — Confirm your result makes sense

## Key Concepts

### Random Number Generation

#### sample() — Selecting from existing values
```r
sample(5)                          # Random permutation of 1-5
sample(10, 4)                      # 4 random values from 1-10
sample(10, 5, replace = TRUE)     # With replacement (allows repeats)
```

#### Probability Distributions — Generating new values

| Distribution | Function | Example | Use Case |
|---|---|---|---|
| Uniform | `runif()` | `runif(10, min=0, max=1)` | Equal probability across range |
| Normal | `rnorm()` | `rnorm(10, mean=50, sd=10)` | Bell-shaped distribution |
| Exponential | `rexp()` | `rexp(5, rate=1)` | Time between events |
| Binomial | `rbinom()` | `rbinom(5, size=10, prob=0.5)` | Number of successes in trials |
| Poisson | `rpois()` | `rpois(5, lambda=3)` | Events in a time interval |

### Reproducibility

```r
set.seed(123)
sample(5)          # Run 1: [2, 4, 1, 5, 3]

set.seed(123)
sample(5)          # Run 2: [2, 4, 1, 5, 3] — Same result!
```

Why it matters: allows research to be replicated and verified.

### The r, d, p, q Convention

R uses consistent naming for all probability distributions:

| Prefix | Meaning | Example | Purpose |
|---|---|---|---|
| `r` | Random generation | `rnorm(100)` | Generate values from distribution |
| `d` | Density | `dnorm(0)` | Height of probability curve at x |
| `p` | Probability (CDF) | `pnorm(1.96)` | Cumulative probability up to x |
| `q` | Quantile (inverse CDF) | `qnorm(0.95)` | x-value for given probability |

Quick memory aid: r = generate, d = density at value, p = probability up to value, q = find value for probability.

### Sampling Techniques

#### 1. Random Sampling (without replacement)
```r
sample_data <- population[sample(nrow(population), 100), ]
```
- Each observation has equal probability of selection
- No observation selected twice
- Best for: representative sample of entire population

#### 2. Systematic Sampling
```r
k <- 10
systematic_sample <- population[seq(1, nrow(population), by = k), ]
```
- Select every k-th observation
- Ordered, predictable pattern
- Best for: populations in sequence (e.g., ID lists)

#### 3. Stratified Sampling
```r
library(dplyr)
stratified_sample <- population %>%
  group_by(gender) %>%
  sample_n(50) %>%
  ungroup()
```
- Divide population into groups (strata)
- Sample from each group
- Best for: ensuring all important subgroups are represented

#### 4. Cluster Sampling
```r
population$cluster <- cut(population$age, breaks = 5)
selected_clusters <- sample(unique(population$cluster), 2)
cluster_sample <- population[population$cluster %in% selected_clusters, ]
```
- Divide population into clusters
- Randomly select clusters
- Use all members from selected clusters
- Best for: geographically dispersed populations

#### 5. Weighted Sampling
```r
weights <- population$income
weighted_sample <- population[sample(nrow(population), 100, prob = weights), ]
```
- Give different selection probabilities
- Higher weight = higher selection chance
- Best for: oversampling important subgroups

#### 6. Convenience Sampling
```r
convenience_sample <- population[1:100, ]
```
- Select easiest-to-access observations
- Biased and unreliable
- Best for: preliminary exploration only

#### 7. Snowball Sampling
- Existing participants recruit others
- Conceptual rather than coded
- Best for: hard-to-reach, hidden populations

### Statistical Testing

#### Kolmogorov–Smirnov (KS) Test
Tests if data match a theoretical distribution:
```r
set.seed(123)
x <- runif(100)
ks.test(x, "punif", min = 0, max = 1)
```

Interpretation:
- p-value > 0.05: Data are consistent with the distribution
- p-value < 0.05: Data do not fit the distribution well

#### Chi-Square Test
Tests if observed frequencies match expected (uniform):
```r
x <- sample(1:6, 100, replace = TRUE)
observed <- table(x)
chisq.test(observed)
```

Interpretation:
- p-value > 0.05: Frequencies are consistent with equal probabilities
- p-value < 0.05: Frequencies differ significantly from expected

## Practice Question

Scenario: Simulate a population of 500 students with ID, age (18-30), gender, and scores from N(60, 12).

Tasks:
1. Create reproducible population with `set.seed()`
2. Display first 6 records
3. Random sample of 50 without replacement
4. Systematic sample with interval 5
5. Stratified sample: 20 from each gender
6. Generate 10 random scores N(60, 12)
7. Find P(Z ≤ 1.96) using `pnorm()`
8. Find 95th percentile using `qnorm()`
9. Chi-square test on 6 equally likely categories

See HCSCI432_Lab2_1_Solutions.R for the complete worked solution.

## Expected Outputs

### pnorm(1.96)
```r
[1] 0.975002
```
Interpretation: 97.5% of the standard normal distribution lies below 1.96.

### qnorm(0.95)
```r
[1] 1.644854
```
Interpretation: The z-score at the 95th percentile is approximately 1.645.

### chisq.test() example
```r
Chi-squared test for given probabilities

data:  observed
X-squared = 1.28, df = 5, p-value = 0.9357
```
Interpretation: p = 0.9357 > 0.05, so frequencies are consistent with a uniform distribution.

## File Structure

```
HCSCI432-Lab2-1-R-Random-Numbers/
├── README.md
├── LAB_SUMMARY.md
├── HCSCI432_Lab2_1.R
├── HCSCI432_Lab2_1_Solutions.R
```

## How to Use This Repository

1. Read this README for an overview.
2. Open HCSCI432_Lab2_1.R and work through each section.
3. Check LAB_SUMMARY.md for detailed explanations.
4. Reference HCSCI432_Lab2_1_Solutions.R when stuck.

## Important Notes

- Type, don't copy. Typing commands helps you understand and retain them.
- Run and observe. After running each command, inspect the output carefully.
- Think before executing. Predict what you expect to happen before running code.
- The dataset is simulated for learning, not real survey data.

## Key Takeaways

1. Reproducibility matters — use `set.seed()` in research.
2. Different sampling methods have different purposes — choose wisely.
3. Probability functions follow a pattern — r, d, p, q make sense once understood.
4. Statistical tests need interpretation — p > 0.05 means consistent with, not proof of.
5. R is powerful for data simulation — use it to explore statistical concepts.

## References

- R Documentation: `?sample`, `?runif`, `?rnorm`, `?pnorm`, `?qnorm`, `?ks.test`, `?chisq.test`
- dplyr Documentation: https://dplyr.tidyverse.org/

---

Course: HCSCI432  
Lab Guide: 2.1  
Topic: Using R for Random Number Generation and Solving Mathematical/Statistical Problems
