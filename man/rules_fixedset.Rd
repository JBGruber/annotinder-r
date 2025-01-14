% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rules.r
\name{rules_fixedset}
\alias{rules_fixedset}
\title{FixedSet ruleset}
\usage{
rules_fixedset(
  can_seek_backwards = TRUE,
  can_seek_forwards = FALSE,
  randomize = FALSE
)
}
\arguments{
\item{can_seek_backwards}{Boolean. Should the coder be allowed to go back to previous unit and edit them?}

\item{can_seek_forwards}{Boolean. Should the coder be allowed to go forward beyond units that have been coded?}
}
\value{
A rules object
}
\description{
A simple ruleset that presents every coder with the exact same units, in the exact order of units (as created with \code{\link{create_units}}).
Note that you can combine this with the jobsets argument in upload_job to specify different fixed sets for different groups of coders.
The order of ids in the jobset unit_id will then be used.
}
\examples{
## to create the rules argument in create_job
rules = rules_fixedset()
}
