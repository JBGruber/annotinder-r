## SET DB FILE
## currently uses this weird workaround where the template is read, modified and then written to a temp
## file to run from. Need to look into plumber whether there's also a way to call programatically
token = NULL
db_file = "DB_FILE"
db = DBI::dbConnect(RSQLite::SQLite(), db_file)


#' @filter cors
cors <- function(req, res) {

  res$setHeader("Access-Control-Allow-Origin", "*")

  if (req$REQUEST_METHOD == "OPTIONS") {
    res$setHeader("Access-Control-Allow-Methods","*")
    res$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
    res$status <- 200
    return(list())
  } else {
    plumber::forward()
  }

}

### GET

#*
#* @param x ...
#* @serializer unboxedJSON
#* @get /login
function(res, req) {
  headers = req$HEADERS
  auth = headers['authorization']
  if (!is.null(auth)) auth = as.character(gsub('Bearer ', '', auth))
  if (!is.null(token) && auth != token) {
    res$status = 401
    list(error = "Invalid token")
  } else {
    list(email='', is_admin=jsonlite::unbox(F), jobs=list())
  }
}

#*
#* @param x ...
#* @serializer unboxedJSON
#* @get /codingjob/<job_id>/codebook
function(job_id) {
  db_get_codebook(db)
}

#*
#* @param x ...
#* @serializer unboxedJSON
#* @get /codingjob/<job_id>/progress
function(job_id) {
  db_get_progress(db)
}

#*
#* @param x ...
#* @serializer unboxedJSON
#* @get /codingjob/<job_id>/unit
function(res, req, job_id) {
  suppressWarnings({
    index = as.numeric(req$argsQuery[['index']])
  })

  if (length(index) == 0) index = NA
  unit = db_get_unit(db, index)

  if (is.null(unit)) {
    res$status = 404
    return(list(error = "no units left"))
  }
  unit
}

#*
#* @param x ...
#* @serializer unboxedJSON
#* @get /codingjob/<job_id>
function(job_id) {
  list()
}




### POST

#*
#* @param x ...
#* @post /codingjob/<job_id>/unit/<unit_id>/annotation
function(req, job_id, unit_id) {
  body = req$argsBody
  unit_id = as.numeric(unit_id)
  db_insert_annotation(db, unit_id, body)
}

