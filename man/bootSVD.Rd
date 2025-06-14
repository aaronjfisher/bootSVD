% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootstrap_functions.R
\name{bootSVD}
\alias{bootSVD}
\title{Calculates bootstrap distribution of PCA (i.e. SVD) results}
\usage{
bootSVD(
  Y = NULL,
  K,
  V = NULL,
  d = NULL,
  U = NULL,
  B = 50,
  output = "HD_moments",
  verbose = getOption("verbose"),
  bInds = NULL,
  percentiles = c(0.025, 0.975),
  centerSamples = TRUE,
  pattern_V = "V_",
  pattern_Vb = "Vb_"
)
}
\arguments{
\item{Y}{initial data sample, which can be either a matrix or a \code{ff} matrix. \code{Y} can be either tall (\eqn{p} by \eqn{n}) or wide (\eqn{n} by \eqn{p}). If \code{Y} is entered and \code{V}, \code{d} and \code{U} (see definitions below) are not entered, then \code{bootSVD} will also compute the SVD of \code{Y}. In this case where the SVD is computed, \code{bootSVD} will assume that the larger dimension of \code{Y} is \eqn{p}, and the smaller dimension of \code{Y} is \eqn{n} (i.e. \code{bootSVD} assumes that \eqn{p>n}. This assumption can be overriden by manually entering \code{V}, \code{U} and \code{d}.\cr
For cases where the entire data matrix can be easily stored in memory (e.g. \eqn{p<50000}), it is generally appropriate to enter \code{Y} as a standard matrix. When \code{Y} is large enough that matrix algebra on \code{Y} is too demanding for memory though, \code{Y} should be entered as a \code{ff} object, where the actual data is stored on disk. If \code{Y} has class \code{ff}, and \code{V}, \code{d} or \code{U} is not entered, then block matrix algebra will be used to calculate the PCs and bootstrap PCs. The results of these calculations will be returned as \code{ff} objects as well.}

\item{K}{number of PCs to calculate the bootstrap distribution for.}

\item{V}{(optional) the (\eqn{p} by \eqn{n}) full matrix of \eqn{p}-dimensional PCs for the sample data matrix. If \code{Y} is wide, these are the right singular vectors of \code{Y} (i.e. \eqn{Y=UDV'}). If \code{Y} is tall, these are the left singular vectors of \code{Y} (i.e. \eqn{Y=VDU'}). In general it is assumed that \eqn{p>n}, however, this can be overridden by setting \code{V} and \code{U} appropriately.\cr
Like \code{Y}, the argument \code{V} can be either a standard matrix or a \code{ff} matrix. If \code{V} is a \code{ff} object, the bootstrap PCs, if requested, will be returned as \code{ff} objects as well.}

\item{d}{(optional) \eqn{n}-length vector of the singular values of \code{Y}. For example, if \code{Y} is tall, then we have \eqn{Y=VDU'} with \code{D=diag(d)}.}

\item{U}{(optional) the (\eqn{n} by \eqn{n}) full set of \eqn{n}-dimensional singular vectors of \code{Y}. If \code{Y} is wide, these are the left singular vectors of \code{Y} (i.e. \eqn{Y=UDV'}). If \code{Y} is tall, these are the right singular vectors of \code{Y} (i.e. \eqn{Y=VDU'}).}

\item{B}{number of bootstrap samples to compute.}

\item{output}{a vector telling which descriptions of the bootstrap distribution should be calculated. Can include any of the following: 'initial_SVD', 'HD_moments', 'full_HD_PC_dist', and 'HD_percentiles'. See below for explanations of these outputs.\cr
For especially high dimensional cases, caution should be used if requesting 'full_HD_PC_dist' due to potential storage limitations.}

\item{verbose}{if TRUE, the function will print progress during calculation procedure.}

\item{bInds}{a (\eqn{B} by \eqn{n}) matrix of bootstrap indeces, where \code{B} is the number of bootstrap samples, and \code{n} is the sample size. The purpose of setting a specific bootstrap sampling index is to allow the results to be more precisely compared against standard bootstrap PCA calculations. If entered, the \code{bInds} argument will override the \code{B} argument.}

\item{percentiles}{a vector containing percentiles to be used to calculate element-wise percentiles across the bootstrap distribution (both across the distribution of  \eqn{p}-dimensional components and the distribution of \eqn{n}-dimensional components). For example, \code{percentiles=c(.025,.975)} will return the 2.5 and 97.5 percentiles, which can be used as \eqn{95} percent bootstrap percentile CIs. Alternatively, a longer vector of percentiles can be entered.}

\item{centerSamples}{whether each bootstrap sample should be centered before calculating the SVD.}

\item{pattern_V}{if \code{Y} is a class \code{ff} object, then the returned PCs of \code{Y} will also be a class \code{ff} object. \code{pattern_V} is passed to \link[ff]{ff} in creation of the \code{initial_SVD} output. Specifically, \code{pattern_V} is a filename prefix used for storing the high dimensional PCs of the original sample.}

\item{pattern_Vb}{if \code{Y} or \code{V} is a class \code{ff} object, then the returned bootstrap PCs will also be class \code{ff} objects. \code{pattern_Vb} is passed to \link[ff]{ff} in creation of the \code{full_HD_PC_dist} output. Specifically, \code{pattern_Vb} is a filename prefix used for storing the high dimensional bootstrap PCs.}
}
\value{
\code{bootSVD} returns a list that can include any of the following elements, depending on what is specified in the \code{output} argument:
\describe{
	\item{initial_SVD}{The singular value decomposition of the centered, original data matrix. \code{initial_SVD} is a list containing \code{V}, the matrix of \eqn{p}-dimensional principal components, \code{d}, the vector of singular values of \code{Y}, and \code{U}, the matrix of \eqn{n}-dimensional singular vectors of \code{Y}.}
\item{HD_moments}{A list containing the bootstrap expected value (\code{EPCs}), element-wise bootstrap variance (\code{varPCs}), and element-wise bootstrap standard deviation (\code{sdPCs}) for each of the \eqn{p}-dimensional PCs. Each of these three elements of \code{HD_moments} is also a list, which contains \eqn{K} vectors, one for each PC. \code{HD_moments} also contains \code{momentCI}, a \eqn{K}-length list of (\eqn{p} by 2) matrices containing element-wise moment based confidence intervals for the PCs.}
\item{full_HD_PC_dist}{A \eqn{B}-length list of matrices (or \code{ff} matrices), with the \eqn{b^{th}} list element equal to the (\eqn{p} by \eqn{K}) matrix of high dimensional PCs for the \eqn{b^{th}} bootstrap sample. \cr
For especially high dimensional cases when the output is returned as \link[ff]{ff} matrices, caution should be used if requesting 'full_HD_PC_dist' due to potential storage limitations. \cr
To reindex these PCs by \eqn{k} (the PC index) as opposed to \eqn{b} (the bootstrap index), see [reindexMatricesByK()]. Again though, caution shoulded be used when reindexing PCs stored as \code{ff} objects, as this will double the number of files stored.}
\item{HD_percentiles}{A list of \eqn{K} matrices, each of dimension (\eqn{p} by \eqn{q}), where \eqn{q} is the number of percentiles requested (i.e. \eqn{q} = \code{length(percentiles)}). The \eqn{k^{th}} matrix in \code{HD_percentiles} contains element-wise percentiles for the \eqn{k^{th}}, \eqn{p}-dimensional PC.}
}



In addition, the following results are always included in the output, regardless of what is specified in the \code{output} argument:
\item{full_LD_PC_dist}{A \eqn{B}-length list of matrices, with the \eqn{b^{th}} list element equal to the (\eqn{p} by \eqn{K}) matrix of PCs of the scores in the \eqn{b^{th}} bootstrap sample. To reindex these vectors by \eqn{k} (the PC index), see [reindexMatricesByK()].}
\item{d_dist}{A \code{B}-length list of vectors, with the \eqn{b^{th}} element of \code{d_dist} containing the \eqn{n}-length vector of singular values from the \eqn{b^{th}} bootstrap sample. To reindex these values by \eqn{k} (the PC index), see [reindexVectorsByK()].}
\item{U_dist}{A \code{B}-length list of (\eqn{n} by \eqn{K}) matrices, with the columns of the \eqn{b^{th}} matrix containing the \eqn{n}-length singular vectors from the \eqn{b^{th}} bootstrap sample. To reindex these vectors by \eqn{k} (the PC index), see [reindexMatricesByK()].}
\item{LD_moments}{A list that is comparable to \code{HD_moments}, but that instead describes the variability of the \eqn{n}-dimensional principal components of the resampled score matrices. \code{LD_moments} contains the bootstrap expected value (\code{EPCs}), element-wise bootstrap variances (\code{varPCs}), and element-wise bootstrap standard deviations (\code{sdPCs}) for each of the \eqn{n}-dimensional PCs. Each of these three elements of \code{LD_moments} is also a list, which contains \eqn{K} vectors, one for each PC. \code{LD_moments} also contains \code{momentCI}, a list of \eqn{K} (\eqn{n} by 2) matrices containing element-wise, moment-based confidence intervals for the PCs.}
\item{LD_percentiles}{A list of \eqn{K} matrices, each of dimension (\eqn{p} by \eqn{q}), where \eqn{q} is the number of percentiles requested (i.e. \eqn{q} = \code{length(percentiles)}). The \eqn{k^{th}} matrix in \code{LD_percentiles} contains element-wise percentiles for the \eqn{k^{th}} \eqn{n}-dimensional PC.
}
}
\description{
Applies fast bootstrap PCA, using the method from (Fisher et al., 2014). Dimension of the sample is denoted by \eqn{p}, and sample size is denoted by \eqn{n}, with \eqn{p>n}.
}
\details{
Users might also consider changing the global options \code{ffbatchbytes}, from the \code{ff} package, and \code{mc.cores}, from the \code{parallel} package. When \code{ff} objects are entered as arguments for \code{bootSVD}, the required matrix algebra is done using block matrix alebra. The \code{ffbatchbytes} option determines the size of the largest block matrix that will be held in memory at any one time. The \code{mc.cores} option (set to 1 by default) determines the level of parallelization to use when calculating the high dimensional distribution of the bootstrap PCs (see \code{\link{mclapply}}).
}
\examples{
#use small n, small B, for a quick illustration
set.seed(0)
Y<-simEEG(n=100, centered=TRUE, wide=TRUE) 
b<-bootSVD(Y, B=50, K=2, output= 
 	c('initial_SVD', 'HD_moments', 'full_HD_PC_dist',
 	'HD_percentiles'), verbose=interactive())
b

#explore results
matplot(b$initial_SVD$V[,1:4],type='l',main='Fitted PCs',lty=1)
legend('bottomright',paste0('PC',1:4),col=1:4,lty=1,lwd=2)

######################
# look specifically at 2nd PC
k<-2

######
#looking at HD variability

#plot several draws from bootstrap distribution
VsByK<-reindexMatricesByK(b$full_HD_PC_dist)
matplot(t(VsByK[[k]][1:20,]),type='l',lty=1,
		main=paste0('20 Draws from bootstrap\ndistribution of HD PC ',k))

#plot pointwise CIs
matplot(b$HD_moments$momentCI[[k]],type='l',col='blue',lty=1,
		main=paste0('CIs For HD PC ',k))
matlines(b$HD_percentiles[[k]],type='l',col='darkgreen',lty=1)
lines(b$initial_SVD$V[,k])
legend('topright',c('Fitted PC','Moment CIs','Percentile CIs'),
		lty=1,col=c('black','blue','darkgreen'))
abline(h=0,lty=2,col='darkgrey')

######
# looking at LD variability

# plot several draws from bootstrap distribution
AsByK<-reindexMatricesByK(b$full_LD_PC_dist)
matplot(t(AsByK[[k]][1:50,]),type='l',lty=1,
		main=paste0('50 Draws from bootstrap\ndistribution of LD PC ',k),
	xlim=c(1,10),xlab='PC index (truncated)')

# plot pointwise CIs
matplot(b$LD_moments$momentCI[[k]],type='o',col='blue',
		lty=1,main=paste0('CIs For LD PC ',k),xlim=c(1,10),
		xlab='PC index (truncated)',pch=1)
matlines(b$LD_percentiles[[k]],type='o',pch=1,col='darkgreen',lty=1)
abline(h=0,lty=2,col='darkgrey')
legend('topright',c('Moment CIs','Percentile CIs'),lty=1,
		pch=1,col=c('blue','darkgreen'))
#Note: variability is mostly due to rotations with the third and fourth PC.

# Bootstrap eigenvalue distribution
dsByK<-reindexVectorsByK(b$d_dist)
boxplot(dsByK[[k]]^2,main=paste0('Covariance Matrix Eigenvalue ',k),
		ylab='Bootstrap Distribution',
		ylim=range(c(dsByK[[k]]^2,b$initial_SVD$d[k]^2)))
points(b$initial_SVD$d[k]^2,pch=18,col='red')
legend('bottomright','Sample Value',pch=18,col='red')


##################
#Example with ff input
library(ff)
Yff<-as.ff(Y, pattern='Y_')
# If desired, change options in 'ff' package to
# adjust the size of matrix blocks held in RAM.
# For example:
# options('ffbatchbytes'=100000)
ff_dir<-tempdir()
pattern_V <- paste0(ff_dir,'/V_')
pattern_Vb <- paste0(ff_dir,'/Vb_')
bff <- bootSVD(Yff, B=50, K=2, output=c('initial_SVD', 'HD_moments',
 	'full_HD_PC_dist', 'HD_percentiles'), pattern_V= pattern_V,
 	pattern_Vb=pattern_Vb, verbose=interactive())


# Note that elements of full_HD_PC_dist and initial_SVD
# have class 'ff'
str(lapply(bff,function(x) class(x[[1]])))
#Show some results of bootstrap draws
plot(bff$full_HD_PC_dist[[1]][,k],type='l')
#Reindexing by K will create a new set of ff files.
VsByKff<-reindexMatricesByK(bff$full_HD_PC_dist,
 	pattern=paste0(ff_dir,'/Vk_'))
physical(bff$full_HD_PC_dist[[1]])$filename
physical(VsByKff[[1]])$filename
matplot(t(VsByKff[[k]][1:10,]),type='l',lty=1,
main=paste0('Bootstrap Distribution of PC',k))


# Saving and moving results:
saveRDS(bff,file=paste0(ff_dir,'/bff.rds'))
close(bff$initial_SVD$V)
physical(bff$initial_SVD$V)$filename
# If the 'ff' files on disk are moved or renamed,
# this filename attribute can be changed:
old_ff_path <- physical(bff$initial_SVD$V)$filename
new_ff_path <- paste0(tempdir(),'/new_V_file.ff')
file.rename(from= old_ff_path, to= new_ff_path)
physical(bff$initial_SVD$V)$filename <- new_ff_path
matplot(bff$initial_SVD$V[,1:4],type='l',lty=1)

}
\references{
Aaron Fisher, Brian Caffo, and Vadim Zipunnikov. \emph{Fast, Exact Bootstrap Principal Component Analysis for p>1 million}. 2014. http://arxiv.org/abs/1405.0922
}
