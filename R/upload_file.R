#' Upload a csv file to Egnyte
#'
#' This function downloads and parses a file of any type from Bulldrive.
#' The raw content will be returned and will need to be parsed for further
#' use if needed.
#'
#' @param x The full path (starting 'Shared/') of the remote file
#' @param path The MIME file type to pull the file in. See \link[httr]{content} for more info
#' @param token Your Bulldrive authentication token (create with \link[bulldriver]{get_token})
#' @param domain The top-level Egnyte domain
#' @export
upload_csv <- function(x, path, token = egnyter::get_parameter("token"), domain = egnyter::get_parameter("domain")) {
  # This function will only work for data frame
  stopifnot(is.data.frame(x))

  # Validate domain
  if(1==0) {
    stop("Invalid or missing Egnyte domain. Use set_token() to set or update it.", call. = FALSE)
  }

  # Validate token
  if(1==0) {
    stop("Invalid or missing Egnyte token Use set_token() to set or update it.", call. = FALSE)
  }

  # Create fully formed upload URL
  full_domain <- paste0(domain, "/pubapi/v1/fs-content/")
  formatted_path <- stringr::str_replace_all(path, " ", "%20")
  final_path <- paste0(full_domain, formatted_path)

  # Write to temp csv file
  tmp_name <- tempfile(fileext = ".csv")
  readr::write_csv(x = x, path = tmp_name)

  # Upload request
  upload_req <- httr::POST(url = final_path, httr::add_headers(Authorization = token), body = httr::upload_file(tmp_name))
  httr::stop_for_status(upload_req)

  # Delete temp file
  file.remove(tmp_name)

  # Return x invisibly
  invisible(x)
}
