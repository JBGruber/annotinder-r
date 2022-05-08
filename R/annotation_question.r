

## In CCS Annotator lingo, questions are a form of annotations where the coder is
## presented with a specific question. This is ideal for crowd coding tasks
## because it requires very little instruction.
#question <- function()


# annotinder argument. if TRUE, can have max 3 codes, which default to left, right, up. Use NA to disable a direction.

#' Create an annotation nquestion
#'
#' Creates a question that can be passed as an argument to \code{\link{create_codebook}}.
#'
#' @param name         The name/label of the question
#' @param instruction  A short (think 1 or 2 sentences) question.
#' @param codes        The codes that the coder can choose from. Can be a character vector, named character vector or data.frame.
#'                     An unnamed character vector creates codes with random colors.
#'                     A named character vector uses the names as codes and the values as colors, either as HEX or a name recognized by browsers (see \url{https://www.w3schools.com/colors/colors_names.asp}).
#'                     A data.frame must have a code column, and can use certain special columns (see details).
#' @param selection    The method for selecting codes/answers. Can be "buttons", "dropdown", "scale" or "annotinder".
#'                     "buttons" shows all answers as buttons, "dropdown" gives a dropdown menu with a search bar.
#'                     "scale" is like buttons, but with a nice layout for likert type scales.
#'                     "annotinder" lets users swipe for answers, and can only be used if the number of answers is 2 or 3.
#'                     The direction for each answer is "left" (first answer), "right" (second answer) and "up" (optional third answer).
#' @param single_row   If "buttons" selection is used, this puts all buttons on the same row (just make sure not to have too many buttons)
#' @param same_size    If "buttons" selection is used, make all buttons the same size.
#'
#' @details
#' Using a data.frame for the codes argument gives more flexibility. This data.frame should have a "code" column, and can in addition have a "color" and "parent" column
#' The color should be a color name, either as HEX or a name recognized by browsers (see \url{https://www.w3schools.com/colors/colors_names.asp})
#' The parent column is only relevant if you have many codes and use selection="dropdown". The dropdown menu will then show the codes with parent names,
#' and parent names are included in the search string. A parent can be the name of another code, and parents can have parents,
#' thus creating trees (just make sure not to create cycles). Use case would for example be an ontology with actor -> government -> president, and issue -> economy -> taxes.
#'
#' @return A question object, to be used within the \code{\link{create_codebook}} function
#' @export
#'
#' @examples
question <- function(name, question, codes=NULL, selection=c("buttons","dropdown","scale", "annotinder"), single_row=F, same_size=F) {
  selection = match.arg(selection)

  l = list(
    name = jsonlite::unbox(name),
    question = jsonlite::unbox(question),
    codes = codes,
    single_row=jsonlite::unbox(single_row),
    same_size=jsonlite::unbox(same_size),
    type= jsonlite::unbox(switch(selection, buttons='select code', dropdown='search code', scale='scale', annotinder='annotinder'))
  )

  if (methods::is(l$codes, 'character')) {
    if (!is.null(names(l$codes))) {
      l$codes = data.frame(code = names(l$codes), color=l$codes)
    } else l$codes = data.frame(code = l$codes)
  }
  if (!methods::is(l$codes, 'data.frame')) stop('The codes argument has to be a character vector, data.frame, or created with the codes() function')
  if (is.null(l$codes$code)) stop('The data.frame passed to the codes argument needs to have a column named "code"')
  structure(l, class=c('codebookQuestion', 'list'))
}


#' S3 print method for codebookQuestion objects
#'
#' @param x an codebookQuestion object, created with \link{variable}
#' @param ... not used
#'
#' @method print codebookQuestion
#' @examples
#' @export
print.codebookQuestion <- function(x, ...){
  for (name in names(x)) {
    if (name == 'codes') next
    if (x[[name]] == F) next
    label = if (name == 'name') 'variable name' else name
    cat(sprintf('%s:\t%s\n', label, x[[name]]))
  }
  cat('\ncodes:\n')
  print(x$codes)
}

#' S3 summary method for codebookQuestion objects
#'
#' @param x an codebookQuestion object, created with \link{variable}
#' @param ... not used
#'
#' @method summary codebookQuestion
#' @examples
#' @export
summary.codebookQuestion <- function(x, ...){
  for (name in names(x)) {
    if (name == 'codes') next
    if (x[[name]] == F) next
    label = if (name == 'name') 'variable name' else name
    cat(sprintf('%s:\t%s\n', label, x[[name]]))
  }
}
