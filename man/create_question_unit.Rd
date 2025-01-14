% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/special_units.r
\name{create_question_unit}
\alias{create_question_unit}
\title{Create a single question unit}
\usage{
create_question_unit(..., markdown = NULL, text_window_size = NULL)
}
\arguments{
\item{...}{Questions to ask, created with \code{\link{question}}. Can be multiple (just as in \code{\link{create_codebook}}.}

\item{markdown}{You can add a unit above the question by providing a markdown string. If empty. the coder will only see the question, See \url{https://commonmark.org/help/} for help.}

\item{text_window_size}{The annotation interface has two parts: text (on top) and the answer form (at the bottom). By default, the text window size is about 70 (70%),
and users can change the size themselves (because the best size might differ depending on device). Here you can optionally set a fixed alternative.
This can for instance be useful if you have a question with big or many buttons, in which case you could set the text window size to something small.
Can also be set to 'auto' so the annotator tries a nice fi (but be sure to test beforehand whether this makes sense for your codebook)}
}
\description{
Sometimes you don't want to ask a coder about a unit, but rather about themselves, or something.
For instance, to include some basic survey questions at the start of a coding set.
Or you might want to create a training example.
}
