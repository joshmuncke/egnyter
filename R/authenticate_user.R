#' Authenticate a user using the Egnyte Filesystem API
#'
#' This function authenticates a user for use of an [Egnyte Filesystem API](https://developers.egnyte.com/docs/read/Public_API_Authentication) application.
#' In order for this function to work you (or an admin) must first create a new API key for your application via the [Egnyte for Developers](https://developers.egnyte.com/member/register) site.
#'
#' @section Details:
#'
#' Use this function to authenticate a specific user for your Egnyter API application.
#' This function will return the authorisation token that is required for the Egnyter `upload_*` and `download_*`
#' functions to operate.
#'
#' You can run this function directly every time your require an authorisation token or use \code{\link{set_token}} to save
#' the token to your options.
#'
#' If your Egnyte username or password changes you will need to re-authenticate yourself and get a new token to continue using Egnyter.
#'
#' @param domain the URL of your Egnyte domain
#' @param app_key API key of your Egnyte application
#' @param username user's Egnyte username
#' @param password user's Egnyte password
#' @export
authenticate_user <- function(domain, app_key, username, password) {
  # Check domain
  if(!validate_domain(domain)) {
    stop("Invalid Egnyte domain.",
         call. = FALSE)
  }

  # Check client id
  if(stringr::str_length(app_key) != 24) {
    stop("Egnyte application key does not look valid. Should be of the form: cba97f3apst9eqzdr5hskggx",
         call. = FALSE)
  }

  # Check username/password
  if(stringr::str_length(username) < 1 || is.null(username) || is.na(username) || stringr::str_length(password) < 1 || is.null(password) || is.na(password)) {
    stop("Invalid Egnyte credentials.",
         call. = FALSE)
  }

  # Add a trailing '/' if not given
  if(stringr::str_sub(domain, -1) != "/") { domain <- paste0(domain,"/") }

  # Create the url and body of the auth call
  authentication_url <- paste0(domain, "puboauth/token")
  authentication_string <- paste0("client_id=", app_key, "&username=", username, "&password=", password, "&grant_type=password")

  # Form the auth request
  auth_request <- httr::POST(
    url = authentication_url,
    body = authentication_string,
    encode = "form",
    handle = NULL)

  # Format the returned token
  token_value <- paste0("Bearer ", httr::content(auth_request, "parsed")$access_token)

  # Error out if we had an upload issue
  httr::stop_for_status(auth_request)

  token_value
}
