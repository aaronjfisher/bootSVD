\name{genQ}
\alias{genQ}
\title{Generate random orthonormal matrix}
\usage{
genQ(n, lim_attempts = 200)
}
\arguments{
  \item{n}{the dimension of the desired random orthonormal
  matrix}

  \item{lim_attempts}{the random matrix of normal noise
  must be full rank to generate the appropriate QR
  decomposition. \code{lim_attempts} gives the maximum
  number of attempts for generating a full rank matrix of
  normal noise.}
}
\value{
a random orthonormal (\eqn{n} by \eqn{n}) matrix
}
\description{
\code{genQ} generates a square matrix of random normal
noise, and then takes the QR decomposition to return Q, a
random orthogonal square matrix.
}
\examples{
A<-genQ(3)
round(crossprod(A),digits=10)
}

