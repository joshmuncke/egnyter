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

  # Replace whitespace in folder paths
  parent_folder <- stringr::str_replace_all(parent_folder, " ", "%20")
  new_folder_name <- stringr::str_replace_all(new_folder_name, " ", "%20")

  # Formatted path of folder to create path
  folder_create_path <- paste0(domain, "pubapi/v1/fs/", parent_folder, "/", new_folder_name)

  # GET request to retrieve file data
  folder_req <- httr::POST(url = folder_create_path,
                           httr::add_headers(Authorization = token),
                           config = httr::content_type("application/json"),
                           data = list('"action":"add_folder"'))

  print(folder_req)

  # Alert us if there's a problem
  httr::stop_for_status(folder_req)

  invisible(folder_create_path)
}
