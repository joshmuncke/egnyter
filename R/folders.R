#' Create a new folder in an Egnyte filesystem
#'
#' This function will create a new folder/directory in an Egnyte filesystem
#'
#' @param parent_folder The full path (starting 'Shared/') of the location that the new folder will be created
#' @param new_folder_name The name of the new folder to create
#' @param token User's Egnyter authorisation token
#' @param domain Egnyte domain URL
#' @export
create_folder <- function(parent_folder, new_folder_name, token = get_parameter("token"), domain = get_parameter("domain")) {
  # Check domain
  if(!egnyter:::validate_domain(domain)) stop("Invalid Egnyte domain.", call. = FALSE)

  # Check authorisation token
  if(!egnyter:::validate_token(token)) stop("Invalid Egnyte token.", call. = FALSE)

  # Add a trailing '/' if not given
  if(stringr::str_sub(domain, -1) != "/") domain <- paste0(domain,"/")

  # Replace whitespace in destination folder path
  source <- stringr::str_replace_all(source, " ", "%20")

  # Formatted download path
  download_path <- paste0(domain, "pubapi/v1/fs-content/", source)

  # GET request to retrieve file data
  file_req <- httr::GET(url = download_path, httr::add_headers(Authorization = token))

  # Alert us if there's a problem
  httr::stop_for_status(file_req)

  # Write content to local file
  file_content <- httr::content(file_req, file_type, encoding = encoding)
  writeBin(file_content, local_dest)

  invisible(local_dest)
}
