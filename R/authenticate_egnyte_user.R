#' Authenticate a user using the Egnyte Filesystem API
#'
#' This function authenticates a user with the [Egnyte
#' Filesystem API](https://developers.egnyte.com/docs/read/Public_API_Authentication).
#'
#' In order for this function to run you must first create
#' a new API key for your application via the [Egnyte for Developers](https://developers.egnyte.com/member/register) site.
#'
#' @param RB_username Your Red Bull corporate username
#' @param RB_password Your Red Bull corporate password
#' @param autoset_env If left as TRUE will save the resulting token as an environment variable
#' @param client_id The default client ID for bulldriver. Can leave as default unless using different API.
#' @param url The top-level Egnyte domain
#' @export
authenticate_egnyte_user <- function(username, password, client_id, domain) {
  # Check client id
  if(stringr::str_length(client_id) != 24) {
    stop("Egnyte client does not look valid. Should be of the form: cba97f3apst9eqzdr5hskggx",
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
  authentication_string <- paste0("client_id=", client_id, "&username=", username, "&password=", password, "&grant_type=password")

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
