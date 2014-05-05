\name{bootSVD}
\alias{bootSVD}
\title{Calculates bootstrap distribution of PCA (i.e. SVD) results}
\usage{
bootSVD(Y, K, V = NULL, d = NULL, U = NULL, B = 50,
  output = "HD_moments", talk = TRUE, bInds = NULL,
  percentiles = c(0.025, 0.975), centerSamples = TRUE, mc.cores = 1)
}
\arguments{
  \item{Y}{initial data sample. Can be either tall (\eqn{p}
  by \eqn{n}) or wide (\eqn{n} by \eqn{p}). If \code{Y} is
  entered and \code{V}, \code{d} and \code{U} are not,
  \code{bootSVD} will also compute the SVD of \code{Y}.}

  \item{K}{number of PCs to calculate the bootstrap
  distribution for.}

  \item{V}{(optional) full set of \eqn{p}-dimensional PCs
  for the sample data matrix. If \code{Y} is wide, these
  are the right singular vectors of \code{Y} (i.e.
  \eqn{Y=UDV'}). If \code{Y} is tall, these are the left
  singular vectors of \code{Y} (i.e. \eqn{Y=VDU'}).}

  \item{U}{(optional) full set of \eqn{n}-dimensional
  singular vectors of \code{Y}. If \code{Y} is wide, these
  are the left singular vectors of \code{Y} (i.e.
  \eqn{Y=UDV'}). If \code{Y} is tall, these are the right
  singular vectors of \code{Y} (i.e. \eqn{Y=VDU'}).}

  \item{d}{(optional) vector of the singular values of
  \code{Y}. For example, if \code{Y} is tall, then we have
  \eqn{Y=VDU'} with \code{D=diag(d)}.}

  \item{B}{number of bootstrap samples to compute.}

  \item{output}{a vector telling which descriptions of the
  bootstrap distribution should be calculated. Can include
  any of the following: 'initial_SVD','HD_moments',
  'full_HD_PC_dist', 'full_LD_PC_dist', 'd_dist', and
  'U_dist'. If \code{output} is set to 'all', then all
  bootstrap PCA results will be reported. See below for
  explanations of these outputs.}

  \item{talk}{If TRUE, the function will print progress
  during calculation procedure.}

  \item{bInds}{a (\eqn{B} by \eqn{n}) matrix of bootstrap
  indeces, where \code{B} is the number of bootstrap
  samples, and \code{n} is the sample size. The purpose of
  setting a specific bootstrap sampling index is to allow
  the results to be more easily compared against standard
  bootstrap PCA calculations. If entered, the \code{bInds}
  argument will override the \code{B} argument.}

  \item{percentiles}{a vector containing percentiles to be
  used to calculate element-wise percentile confidence
  intervals for the PCs (both the \eqn{p}-dimensional
  components and the \eqn{n}-dimensional components). For
  example, \code{percentiles=c(.025,.975)} will result in
  \eqn{95%} CIs.}

  \item{mc.cores}{passed to \code{\link{mclapply}}. Used
  when transforming the \eqn{n}-dimensional PCs to the
  \eqn{p}-dimensional PCs.}

  \item{centerSamples}{whether each bootstrap sample should
  be centered before calculating the SVD.}
}
\value{
Output is a list which can include any of the following
elements, depending on what is specified in the
\code{output} argument: \describe{ \item{initial_SVD}{The
singular value decomposition of the centered, original data
matrix. \code{initial_SVD} is a list containing \code{V},
the matrix of \eqn{p}-dimensional principal components,
\code{d}, the vector of singular values of \code{Y}, and
\code{U}, the matrix of \eqn{n}-dimensional singular
vectors of \code{Y}.} \item{HD_moments}{A list containing
the bootstrap expected value (\code{EPCs}), element-wise
bootstrap variance (\code{varPCs}), and element-wise
bootstrap standard deviation (\code{sdPCs}) for each of the
\eqn{p}-dimensional PCs. Each of these three elements of
\code{HD_moments} is also a list, which contains \eqn{K}
vectors, one for each PC. \code{HD_moments} also contains
\code{momentCI}, a \eqn{K}-length list of (\eqn{p} by 2)
matrices containing element-wise moment based confidence
intervals for the PCs.} \item{full_HD_PC_dist}{A
\eqn{B}-length list of matrices, with the \eqn{b^{th}}
element equal to the (\eqn{p} by \eqn{K}) matrix of fitted
PCs from the \eqn{b^{th}} bootstrap sample. To reorganize
these matrices into a \code{K}-length list of (\code{B} by
\code{p}) matrices, the \code{\link{reindexPCsByK}} can be
used.} \item{HD_percentiles}{A list of \eqn{K} matrices,
each of dimension (\eqn{p} by \eqn{2}). The \eqn{k^{th}}
matrix in \code{HD_percentiles} contains element-wise
percentile intervals for the \eqn{k^{th}}
\eqn{p}-dimensional PC.} \item{full_LD_PC_dist}{A
\eqn{B}-length list of matrices, with the \eqn{b^{th}}
element equal to the (\eqn{n} by \eqn{K}) matrix of fitted
PCs from the \eqn{b^{th}} bootstrap score sample. To
reorganize these matrices into a \code{K}-length list of
(\code{B} by \code{n}) matrices, the
\code{\link{reindexPCsByK}} can be used.} \item{d_dist}{A
\code{B}-length list of vectors, with the \eqn{b^{th}}
element of \code{d_dist} containing the \eqn{n}-length
vector of singular values from the \eqn{b^{th}} bootstrap
sample.} \item{U_dist}{A \code{B}-length list of (\eqn{n}
by \eqn{K}) matrices, with the columns of the \eqn{b^{th}}
matrix containing the \eqn{n}-length singular vectors from
the \eqn{b^{th}} bootstrap sample.} }

In addition, the following results are always included in
the output, regardless of what is specified in the
\code{output} argument: \item{LD_moments}{A list that is
comparable to \code{HD_moments}, but instead describes the
variability of the \eqn{n}-dimensional principal components
of the resampled score matrices. \code{LD_moments} contains
the bootstrap expected value (\code{EPCs}), bootstrap
variance (\code{varPCs}), and bootstrap standard deviation
(\code{sdPCs}) for each of the \eqn{n}-dimensional PCs.
Each of these three elements of \code{LD_moments} is also a
list, which contains \eqn{K} vectors, one for each PC.
\code{LD_moments} also contains \code{momentCI}, a list of
\eqn{K} (\eqn{n} by 2) matrices containing element-wise
moment based confidence intervals for the PCs.}
\item{LD_percentiles}{A list of \eqn{K} matrices, each of
dimension (\eqn{n} by \eqn{2}). The \eqn{k^{th}} matrix in
\code{LD_percentiles} contains element-wise percentile
intervals for the \eqn{k^{th}} \eqn{n}-dimensional PC. }
}
\description{
Applies fast bootstrap PCA, using the method from (Fisher
et al., 2014). Dimension of the sample is denoted by
\eqn{p}, and sample size is denoted by \eqn{n}.
}
\examples{
#use small n, small B for a quick illustration
set.seed(0)
Y<-simEEG(n=100, centered=TRUE, wide=TRUE)
b<-bootSVD(Y,B=200,K=2,output='all')

#explore results
matplot(b$initial_SVD$V[,1:4],type='l',main='Fitted PCs',lty=1)
legend('bottomright',paste0('PC',1:4),col=1:4,lty=1,lwd=2)

######################
# look specifically at 2nd PC
k<-2

######
#looking at HD variability

#plot several draws from bootstrap distribution
VsByK<-reindexPCsByK(b$full_HD_PC_dist)
matplot(t(VsByK[[k]][1:20,]),type='l',lty=1,main=paste0('20 Draws from bootstrap\\ndistribution of HD PC ',k))

#plot pointwise CIs
matplot(b$HD_moments$momentCI[[k]],type='l',col='blue',lty=1,main=paste0('CIs For HD PC ',k))
matlines(b$HD_percentiles[[k]],type='l',col='darkgreen',lty=1)
lines(b$initial_SVD$V[,k])
legend('topright',c('Fitted PC','Moment CIs','Percentile CIs'),lty=1,col=c('black','blue','darkgreen'))
abline(h=0,lty=2,col='darkgrey')

######
# looking at LD variability

# plot several draws from bootstrap distribution
AsByK<-reindexPCsByK(b$full_LD_PC_dist)
matplot(t(AsByK[[k]][1:50,]),type='l',lty=1,main=paste0('50 Draws from bootstrap\\ndistribution of LD PC ',k),xlim=c(1,10),xlab='PC index (truncated)')

# plot pointwise CIs
matplot(b$LD_moments$momentCI[[k]],type='o',col='blue',lty=1,main=paste0('CIs For LD PC ',k),xlim=c(1,10),xlab='PC index (truncated)',pch=1)
matlines(b$LD_percentiles[[k]],type='o',pch=1,col='darkgreen',lty=1)
abline(h=0,lty=2,col='darkgrey')
legend('topright',c('Moment CIs','Percentile CIs'),lty=1,pch=1,col=c('blue','darkgreen'))
#Note: variability is mostly due to rotations with the third and fourth PC.

# Bootstrap eigenvalue distribution
dsByK<-reindexDsByK(b$d_dist)
boxplot(dsByK[[k]]^2,main=paste0('Covariance Matrix Eigenvalue ',k),ylab='Bootstrap Distribution')
points(b$initial_SVD$d[2]^2,pch=18,col='red')
legend('bottomright','Sample Value',pch=18,col='red')
}
\references{
Aaron Fisher, Brian Caffo, and Vadim Zipunnikov.
\emph{Fast, Exact Bootstrap Principal Component Analysis
for p>1 million}. Working Paper, 2014.
}

