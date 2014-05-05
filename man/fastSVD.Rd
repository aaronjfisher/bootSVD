\name{fastSVD}
\alias{fastSVD}
\title{Fast SVD of a wide or tall matrix}
\usage{
fastSVD(A, nv = min(dim(A)), warning_type = "silent")
}
\arguments{
  \item{A}{matrix of dimension (\eqn{n} by \eqn{m}).}

  \item{nv}{number of high dimensional singular vectors to
  obtain. If \eqn{n>m}, this is the number of
  \eqn{n}-dimensional left singular vectors to be computed.
  If \eqn{n<m}, this is the number of \eqn{m}-dimensional
  right singular vectors to be computed.}

  \item{warning_type}{passed to \code{\link{qrSVD}}, which
  calculates \code{svd(tcrossprod(A))}}
}
\value{
Let \eqn{r} be the rank of the matrix \code{A}.
\code{fastSVD} solves \eqn{svd(A)=UDV'}, where \eqn{U} is
an (\eqn{n} by \eqn{r}) orthonormal matrix, \eqn{D} is an
(\eqn{r} by \eqn{r}) diagonal matrix; and \eqn{V} is a
(\eqn{m} by \eqn{r}) orthonormal matrix. For matrices where
one dimension is substantially large than the other,
calculation times are considerably faster than the standard
\code{svd} function.
}
\description{
\code{fastSVD} uses the inherent low dimensionality of a
wide, or tall, matrix to quickly calculate its SVD. For a
matrix \eqn{A}, this function solves \eqn{svd(A)=UDV'}.
}
\examples{
Y<-simEEG(n=100,centered=TRUE,wide=TRUE)
svdY<-fastSVD(Y)
V<-svdY$v #sample PCs for a wide matrix are the right singular vectors
matplot(V[,1:5],type='l',lty=1) #PCs from simulated data

#Note: For a tall, demeaned matrix Y, with columns corresponding to subjects and rows to measurements,
#the PCs are the high dimensional left singular vectors.
}

