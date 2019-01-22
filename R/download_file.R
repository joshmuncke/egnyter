#' Download a file from Bulldrive (any format)
#'
#' This function downloads and parses a file of any type from Bulldrive.
#' The raw content will be returned and will need to be parsed for further
#' use if needed.
#'
#' @param file_path The full path (starting 'Shared/') of the remote file
#' @param file_type The MIME file type to pull the file in. See \link[httr]{content} for more info
#' @param token Your Bulldrive authentication token (create with \link[bulldriver]{get_token})
#' @param url The top-level Egnyte domain
#' @param encoding The default encoding to use for the content translation
#' @export
download_file <- function(file_path, file_type = "text", token = Sys.getenv("EGNYTETOKEN"), url = Sys.getenv("EGNYTEDOMAIN"), encoding = "ISO-8859-1") {
  file_url <- paste0(url, "pubapi/v1/fs-content/")
  file_path <- stringr::str_replace_all(file_path, " ", "%20")
  file_path <- paste0(file_url, file_path)
  file_req <- httr::GET(url = file_path, httr::add_headers(Authorization = token))

  # Alert us if there's a problem
  httr::stop_for_status(file_req)

  httr::content(file_req, file_type, encoding = encoding)
}
