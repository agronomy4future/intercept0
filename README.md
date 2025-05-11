<!-- README.md is generated from README.Rmd. Please edit that file -->
# intercept0

<!-- badges: start -->
<!-- badges: end -->

This package calculates the correct R² when the intercept in a linear regression is forced to 0

□ Code summary: https://github.com/agronomy4future/r_code/blob/main/R_package_intercept0.ipynb

□ Code explained: https://agronomy4future.com/archives/24170

## Installation

You can install the development version of fwrmodel like so:

Before installing, please download Rtools (https://cran.r-project.org/bin/windows/Rtools)

``` r
if(!require(remotes)) install.packages("remotes")
if (!requireNamespace("intercept0", quietly = TRUE)) {
  remotes::install_github("agronomy4future/intercept0")
}

library(remotes)
library(intercept0)
```

## Example

``` r
x=c(19.5,40.8,45.2,55.3,24.9,49,50,NA,32.3,42.6,54.2,52.9,64.3,53.6,34.1,18.1,66.7,57.2,37.1,58.1,67.2,53.5,63,42.1,34.9,NA,23)
y=c(20.41,NA,36.57,50.34,23.07,44.98,44.35,29.27,28.10,40.89,52.16,49.04,61.57,52.3,40.86,23.18,60.13,NA,35.37,54.46,59.88,45.96,53.9,39.33,34.58,61.35,25.37)
df=data.frame (x,y)

model= intercept0(grain_weight ~ grain_area, data=df)
summary(model)

Call:
Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
x  0.92574    0.01476   62.72   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.371 on 22 degrees of freedom
  (4 observations deleted due to missingness)
Multiple R-squared:  0.9944,	Adjusted R-squared:  0.9942 
F-statistic:  3934 on 1 and 22 DF,  p-value: < 2.2e-16

[1] Corrected R-squared: 0.9279126 
```
