\docType{data}
\name{EEG_leadingV}
\alias{EEG_leadingV}
\title{Leading 5 Principal Components (PCs) from EEG dataset}
\description{
This package is based on (Fisher et al., 2014), which uses
as an example a subset of the electroencephalogram (EEG)
measurements from the Sleep Heart Health Study (SHHS) (Quan
et al. 1997). Since we cannot publish the EEG recordings
from SHHS participants in this package, we instead include
the summary statistics of the PCs from our subsample of the
processed SHHS EEG data. These summary statistics were
generated from measurements of smoothed Normalized Delta
Power. This data is used by the \code{\link{simEEG}} to
simulate data examples to demonstrate our functions.
}
\details{
Specifically, \code{EEG_leadingV} is a matrix whose columns
contain the leading 5 principal components of the EEG
dataset.
}
\references{
Aaron Fisher, Brian Caffo, and Vadim Zipunnikov.
\emph{Fast, Exact Bootstrap Principal Component Analysis
for p>1 million}. 2014. http://arxiv.org/abs/1405.0922

Stuart F Quan, Barbara V Howard, Conrad Iber, James P
Kiley, F Javier Nieto, George T O'Connor, David M Rapoport,
Susan Redline, John Robbins, JM Samet, et al.\emph{ The
sleep heart health study: design, rationale, and methods}.
Sleep, 20(12):1077-1085, 1997. 1.1
}
\seealso{
\code{\link{EEG_mu}}, \code{\link{EEG_score_var}}
}
\keyword{data}

