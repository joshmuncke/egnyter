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
download_file <- function(file_path, file_type = "raw", encoding = "ISO-8859-1", token = get_parameter("token"), domain = get_parameter("domain")) {

  # Add a trailing '/' if not given
  if(stringr::str_sub(domain, -1) != "/") { domain <- paste0(domain,"/") }

  file_api_url <- paste0(domain, "pubapi/v1/fs-content/")
  file_path_cleaned <- stringr::str_replace_all(file_path, " ", "%20")
  full_url <- paste0(file_api_url, file_path_cleaned)
  file_req <- httr::GET(url = full_url, httr::add_headers(Authorization = token))

  # Alert us if there's a problem
  httr::stop_for_status(file_req)

  httr::content(file_req, file_type, encoding = encoding)
}
