bootSVD
=======

The R package bootSVD can be used to implement fast, exact bootstrap principal component analysis and singular value decompositions for high dimensional data, where the number of measurements per subject is much larger than the number of subjects. This package is based on the methodology outlined by Fisher et al. (2014), who demonstrate the method on a dataset of 352 brain magnetic resonace images (MRIs), with approximately 3 million measurements per subject.

The primary function in this package is the bootSVD function, for which we include a documented example based on simulated sleep electroencephalogram (EEG) data.

To install:
```S
## if needed
install.packages("devtools")

## main package
library(devtools)
install_github('bootSVD','aaronjfisher')

## to access help pages
library(bootSVD)
help(package=bootSVD)
``` 
<br/><br/>

References: 

Aaron Fisher, Brian Caffo, and Vadim Zipunnikov. *Fast, Exact Bootstrap Principal Component Analysis for p>1 million.* Working Paper, 2014. [http://arxiv.org/abs/1405.0922](http://arxiv.org/abs/1405.0922)







