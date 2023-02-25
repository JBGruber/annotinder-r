
#' Open the annotator client
#'
#' Opens the annotator client. If you're running RStudio, it will try to use the Viewer.
#' Otherwise, it will open in your default webbrowser.
#'
#' @param in_browser Can be TRUE if you want to force opening in the default webbrowser
#'
#' @return Nothing
#' @export
#'
#' @examples
#' annotator_client()
annotator_client <- function(in_browser=FALSE, host) {
  react_build = system.file("annotinder_client", package="annotinder", mustWork=T)

  tf = tempdir()
  file.copy(react_build, tf, recursive = T, overwrite = T)
  browser_url <- file.path(tf, 'annotinder_client/build/index.html')
  js <- readLines(file.path(tf, 'annotinder_client/build/static/js/main.8452cd4e.js'), warn = FALSE)
  js <- gsub("http://localhost:8000", host, js, fixed = TRUE)
  writeLines(js, file.path(tf, 'annotinder_client/build/static/js/main.8452cd4e.js'))

  viewer = getOption("viewer")

  if (is.null(viewer) || in_browser) {
    utils::browseURL(browser_url)
  } else {
    viewer(browser_url)
  }
}
