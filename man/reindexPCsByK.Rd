\name{reindexPCsByK}
\alias{reindexPCsByK}
\title{Allows for calculation of low dimensional standard errors & percentiles, by re-indexing the \eqn{A^b} by PC index (\eqn{k}) rather than bootstrap index (\eqn{b}).}
\usage{
reindexPCsByK(PCsByB)
}
\arguments{
  \item{PCsByB}{a \code{B}-length list of (\code{r} by
  \code{K}) bootstrap PCs matrices for each bootstrap
  sample, where \code{K} is the number of PCs of interest
  and \code{B} is the number of bootstrap samples. These
  may refer to the '\eqn{n}-dimensional' components
  \eqn{A^b} (i.e. \eqn{r:=n}), or to the high dimensional
  components \eqn{V^b} (i.e. \eqn{r:=p}). In both cases,
  the input matrices should be indexed by \eqn{b}, where
  \eqn{b=1,2,...B}.}
}
\value{
a \code{K}-length list of (\eqn{B} by \eqn{r}) PC matrices.
If \code{PCsByK} is the output of \code{reindexPCsByK},
then \code{PCsByK[[k]][b,]} is the \eqn{k^{th}} fitted PC
from the \code{b^{th}} bootstrap sample. This allows for
quick estimation of low dimensional moments, or
percentiles. Moments can also be directly calculated by the
\code{\link{getMomentsAndMomentCI}} function.
}
\description{
This function is used as a precursor step for calculate
bootstrap standard errors, or percentiles. For very high
dimensional data, we recommend that the this function be
applied to the low dimensional components \eqn{A^b}, but
the function can also be used to reorder a list of high
dimensional bootstrap PCs. In general, we recommend that as
many operations as possible be applied to the low
dimensional components, as opposed to their high
dimensional counterparts.  This function is called by
\code{\link{getMomentsAndMomentCI}}.
}
\examples{
#use small n, small B for a quick illustration
set.seed(0)
Y<-simEEG(n=100, centered=TRUE, wide=TRUE)
svdY<-fastSVD(Y)
V<- svdY$v #original sample PCs
DUt<- tcrossprod(diag(svdY$d),svdY$u)
bInds<-genBootIndeces(B=200,n=dim(DUt)[2])
bootSVD_LD_output<-bootSVD_LD(DUt=DUt,bInds=bInds,K=3,talk=TRUE)

########
# to get 'low dimensional PC' moments and lower percentiles
AsByB<-bootSVD_LD_output$As
AsByK<-reindexPCsByK(AsByB)

meanA1<-	apply(AsByK[[1]],2,mean)
seA1<-	apply(AsByK[[1]],2,sd)
pA1<-	apply(AsByK[[1]],2,function(x) quantile(x,.05))
#can also use lapply to get a list (indexed by k=1,...K) of the means, standard errors, or percentiles for each PC. See example below, for high dimensional bootstrap PCs.

#Alternatively, moments can be calculated with
seA1_v2<- getMomentsAndMomentCI(As=AsByB,V=diag(dim(AsByB[[1]])[1]))$sdPCs[[1]]
all(seA1_v2==seA1)

#Additional examples of exploring the low dimensional bootstrap PC distribution are given in the documentation for the 'bootSVD' function.
#########

#########
#High dimensional percentiles for each PC
VsByB<-As2Vs(As=AsByB,V=V)
VsByK<-reindexPCsByK(VsByB)
percentileCI_Vs<-lapply(VsByK,function(mat_k){
	apply(mat_k,2,function(x) quantile(x,c(.025,.975)))
})
k=2 # the 2nd PC is a little more interesting here.
matplot(t(percentileCI_Vs[[k]]),type='l',lty=1,col='blue')
lines(V[,k])
########
}

