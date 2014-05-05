\name{reindexDsByK}
\alias{reindexDsByK}
\title{Allows for study of the bootstrap distribution of the k^th singular values, by re-indexing the list of \eqn{d^b} vectors to be organized by PC index (\eqn{k}) rather than bootstrap index (\eqn{b}).}
\usage{
reindexDsByK(dsByB)
}
\arguments{
  \item{dsByB}{a list of vectors, with each vector
  containing the \code{n} singular values from a different
  bootstrap sample.}
}
\value{
a \code{K}-length list of (\eqn{B} by \eqn{n}) matrices,
where each matrices' rows refers to the singular values
from a different bootstrap sample.
}
\description{
Allows for study of the bootstrap distribution of the k^th
singular values, by re-indexing the list of \eqn{d^b}
vectors to be organized by PC index (\eqn{k}) rather than
bootstrap index (\eqn{b}).
}
\examples{
set.seed(0)
Y<-simEEG(n=100, centered=TRUE, wide=TRUE)
svdY<-fastSVD(Y)
DUt<- tcrossprod(diag(svdY$d),svdY$u)
bInds<-genBootIndeces(B=200,n=dim(DUt)[2])
bootSVD_LD_output<-bootSVD_LD(DUt=DUt,bInds=bInds,K=3,talk=TRUE)

dsByK<-reindexDsByK(bootSVD_LD_output$ds)

boxplot(dsByK[[1]],main='Bootstrap distribution of 1st singular value')
}

