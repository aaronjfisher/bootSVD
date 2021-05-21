bootSVD
=======
[![Build Status](https://travis-ci.org/aaronjfisher/bootSVD.png?branch=master)](https://travis-ci.org/aaronjfisher/bootSVD)

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

Aaron Fisher, Brian Caffo, Brian Schwartz, Vadim Zipunnikov (2016). Fast, exact bootstrap principal component analysis for p > 1 million. *Journal of the American Statistical Association TM.* <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5014451/" target="_blank">https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5014451/</a>







