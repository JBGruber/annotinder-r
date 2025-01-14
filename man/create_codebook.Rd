% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/codebook.r
\name{create_codebook}
\alias{create_codebook}
\title{Create a codebook for the CCS Annotator}
\usage{
create_codebook(...)
}
\arguments{
\item{...}{Questions for "questions" mode or Variables for "annotate" mode. See \code{\link{codebook_variable}}
Cannot combine "annotate" and "question", because these are very different annotation modes.}
}
\value{
A codebook object
}
\description{
Create a codebook for the CCS Annotator
}
\examples{
variable = annotation_variable("sentiment", "Assign sentiment to words",
  codes = c(Negative='red', Neutral='grey', Positive='green'))

create_codebook(variable)
}
