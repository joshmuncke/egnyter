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
download_feather <- function (file_path, encoding = "ISO-8859-1", token = get_parameter("token"), domain = get_parameter("domain"))
{
  file_content <- egnyter::download_file(file_path, "raw", encoding, token, domain)
  tmp_name <- tempfile(fileext = ".feather")
  writeBin(file_content, tmp_name)
  f_data <- feather::read_feather(tmp_name)
  file.remove(tmp_name)
  f_data
}

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
download_csv <- function (file_path, encoding = "ISO-8859-1", token = get_parameter("token"), domain = get_parameter("domain"))
{
  file_content <- egnyter::download_file(file_path, "raw", encoding, token, domain)
  tmp_name <- tempfile(fileext = ".csv")
  writeBin(file_content, tmp_name)
  f_data <- readr::read_csv(tmp_name)
  file.remove(tmp_name)
  f_data
}

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
download_excel <- function (file_path, encoding = "ISO-8859-1", token = get_parameter("token"), domain = get_parameter("domain"), ...)
{
  file_extension <- stringr::str_extract(file_path, "(\\.[^.]+)$")
  if (file_extension != ".xlsx" && file_extension != ".xls") {
    stop("This function is for downloading Excel files only", call. = FALSE)
  }

  file_content <- egnyter::download_file(file_path, "raw", encoding, token, domain)
  tmp_name <- paste0(tempfile(), file_extension)
  writeBin(file_content, tmp_name)
  f_data <- readxl::read_excel(path = tmp_name, ...)
  file.remove(tmp_name)
  invisible(f_data)
}

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
download_rdata <- function (file_path, encoding = "ISO-8859-1", token = get_parameter("token"), domain = get_parameter("domain")) {
  file_content <- egnyter::download_file(file_path, "raw", encoding, token, domain)
  tmp_name <- tempfile(fileext = ".Rda")
  writeBin(file_content, tmp_name)
  f_data <- load(tmp_name, .GlobalEnv)
  nameofobjects <- get(f_data)
  file.remove(tmp_name)
  invisible(nameofobjects)
}
