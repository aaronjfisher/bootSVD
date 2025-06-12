bootSVD
=======

[![R-CMD-check](https://github.com/aaronjfisher/bootSVD/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aaronjfisher/bootSVD/actions/workflows/R-CMD-check.yaml)


The R package bootSVD can be used to implement fast, exact bootstrap principal component analysis and singular value decompositions for high dimensional data, where the number of measurements per subject is much larger than the number of subjects. This package is based on the methodology outlined by Fisher et al. (2014), who demonstrate the method on a dataset of 352 brain magnetic resonace images (MRIs), with approximately 3 million measurements per subject.

The primary function in this package is the bootSVD function, for which we include a documented example based on simulated sleep electroencephalogram (EEG) data. When the data is too large to store in memory, functions in this package can also be applied to objects of class `ff`. These `ff` objects have a representation in memory, but store their primary contents on disk (see [the ff package](https://CRAN.R-project.org/package=ff)). 

Speed improvements are driven by the fact that sample size (n) is much less than sample dimension, which allows a n-dimensional representation of the sample to be sufficient for many calculations.

To install:
```S
## if needed
install.packages("devtools")

## main package
library(devtools)
install_github('aaronjfisher/bootSVD')

library(bootSVD)

## to access help pages
help(package=bootSVD)
?bootSVD
``` 
<br/><br/>

References: 

Aaron Fisher, Brian Caffo, Brian Schwartz and Vadim Zipunnikov. *Fast, Exact Bootstrap Principal Component Analysis for p>1 million.* Journal of the American Statistical Association: Theory and Methods, 2016. [https://doi.org/10.1080/01621459.2015.1062383](https://doi.org/10.1080/01621459.2015.1062383)







