% File sme/man/sme.data.frame.Rd
% Part of the sme package for R
% Distributed under GPL 3 or later: see sme/LICENCE
\name{sme.data.frame}
\title{Smoothing-splines mixed-effects model fit(s) from a data.frame object}
\usage{
\method{sme}{data.frame}(object,tme,ind,verbose=F,lambda.mu=NULL,lambda.v=NULL,maxIter=500,
knots=NULL,zeroIntercept=F,deltaEM=1e-3,deltaNM=1e-3,criteria="AICc",\dots)
}
\alias{sme.data.frame}
\arguments{
  \item{object}{a \code{data.frame} with named variables \code{y}, \code{tme}, \code{ind} and,
  optionally, \code{variable}. The first three represent observations, corresponding time points and
  correpsonding subjects respectively. If \code{variable} is missing then these are used to carry
  out a single model fit. If \code{variable} is present then it denotes variable membership, and a
  separate smoothing-splines mixed-effects model is fit to each unique variable}
  \item{tme}{for consistency with the generic function. Ignored in this case}
  \item{ind}{for consistency with the generic function. Ignored in this case}
  \item{verbose}{if \code{TRUE}, debug information will be output while fitting the model(s)}
  \item{lambda.mu}{in the case of carrying out a single model fit, either a smoothing parameter to
  be used for the fixed-effect function or \code{NULL} if the optimal values for this and
  \code{lambda.v} should be found according to \code{criteria} using Nelder-Mead search. For the
  case of multiple model fits, either a single smoothing parameter to be used for all fits, or a 
  vector of smoothing parameters, one for each fit, or \code{NULL} if Nelder-Mead search should be
  used to find the optimal values for this and \code{lambda.v} for all variables}
  \item{lambda.v}{in the case of carrying out a single model fit, either a smoothing parameter to
  be used for the random-effects functions or \code{NULL} if the optimal values for this and
  \code{lambda.mu} should be found according to \code{criteria} using Nelder-Mead search. For the
  case of multiple model fits, either a single smoothing parameter to be used for all fits, or a 
  vector of smoothing parameters, one for each fit, or \code{NULL} if Nelder-Mead search should be
  used to find the optimal values for this and \code{lambda.mu} for all variables}
  \item{maxIter}{maximum number of iterations to be performed for the EM algorithm}
  \item{knots}{location of spline knots. If \code{NULL}, an incidence matrix representation will be
  used. See `Details'}
  \item{zeroIntercept}{experimental feature. If \code{TRUE}, the fitted values of the fixed- and
  random-effects functions at the intercept will be zero}
  \item{deltaEM}{convergence tolerance for the EM algorithm}
  \item{deltaNM}{(relative) convergence tolerance for the Nelder-Mead optimisation}
  \item{criteria}{one of \code{"AICc"}, \code{"AIC"}, \code{"BICN"} or \code{"BICn"} indicating
  which criteria to use to score a particular combination of \code{lambda.mu} and \code{lambda.v} in
  the Nelder-Mead search}
  \item{\dots}{additional arguments used when carrying out multiple fits, specifically
  \code{numberOfThreads} indicating the number of threads used to carry out the multiple fits in
  parallel. See \code{sme.list} for details}
}
\description{
  Carry out one or more independent smoothing-splines mixed-effects model fits simultaneously
}
\value{
  In the case of a single model fit, an object of class \code{sme}. For multiple model fits, a list
  of such objects. See \code{smeObject} for the components of the fit and \code{plot.sme} for
  visualisation options
}
\details{
The default behaviour is to use an incidence matrix representation for the smoothing-splines. This
works well in most situations but may incur a high computational cost when the number of distinct
time points is large, as may be the case for irregularly sampled data. Alternatively, a basis
projection can be used by giving a vector of \code{knots} of length (much) less than the number of
distinct time points.
}
\references{
  Berk, M. (2012). \emph{Smoothing-splines Mixed-effects Models in R}. Preprint
}
\author{Maurice Berk \email{maurice.berk01@imperial.ac.uk}}
\seealso{\code{\link{smeObject}}, \code{\link{sme}}, \code{\link{sme.list}}, \code{\link{plot.sme}}}
\examples{
  data(MTB)
  system.time(fits <- sme(MTB,numberOfThreads=1))
  sapply(fits,logLik)

  system.time(fits <- sme(MTB,numberOfThreads=10))
  sapply(fits,logLik)
}