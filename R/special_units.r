#' Create a special unit for asking questions
#'
#' Sometimes you don't want to ask a coder about a unit, but rather about themselves, or something.
#' For instance, to include some basic survey questions at the start of a coding set.
#'
#' @param title   A title
#' @param text    Some text to introduce the
#' @param ...     Questions to ask, created with the \code{\link{question}}
#' @param text_window_size The annotation interface has two parts: text (on top) and the answer form (at the bottom). By default, the text window size is about 70 (70%),
#'                         and users can change the size themselves (because the best size might differ depending on device). Here you can optionally set a fixed alternative.
#'                         This can for instance be useful if you have a question with big or many buttons, in which case you could set the text window size to something small.
#'
#' @return
#' @export
#'
#' @examples
create_question_unit <- function(title, text, ..., text_window_size=NULL) {
  units = create_units(data.frame(id=title, title=title, text=text), id='id', text=text_fields(
    text_field('title', bold=T, center=T, size='1.4'),
    text_field('text')
  ))
  units = prepare_units(units, NULL)
  unit = units[[1]]
  unit$unit$codebook = create_codebook(...)
  if (!is.null(text_window_size)) {
    if (!class(text_window_size) == 'numeric') stop('text_window_size must be numeric')
    if (text_window_size < 0 || text_window_size > 80) stop('text window size must be a value between 0 and 80')
    unit$unit$text_window_size = text_window_size
  }
  unit
}

#' Create a special unit for informing coders
#'
#' @param title   A title
#' @param text    The information text
#'
#' @return
#' @export
#'
#' @examples
create_info_unit <- function(title, text) {
  units = create_units(data.frame(id=title, title=title, text=text), id='id', text=text_fields(
    text_field('title', bold=T, center=T, size='1.4'),
    text_field('text')
  ))
  units = prepare_units(units, NULL)
  unit = units[[1]]
  unit$unit$codebook = list(type='questions', questions=list(list(name='confirm', type='confirm')))
  unit
}
