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
download_feather <- function (file_path, file_type = "raw", encoding = "ISO-8859-1", token = get_parameter("token"), domain = get_parameter("domain"))
{
  file_content <- egnyter::download_file(file_path, file_type, encoding, token, domain)
  tmp_name <- tempfile(fileext = ".feather")
  writeBin(file_content, tmp_name)
  f_data <- feather::read_feather(tmp_name)
  file.remove(tmp_name)
  f_data
}
