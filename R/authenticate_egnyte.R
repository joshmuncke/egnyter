# Authenticate a user using the Egnyte Filesystem API
#
# This function authenticates a user with the [Egnyte
# Filesystem API](https://developers.egnyte.com/docs/read/Public_API_Authentication).
#
# In order for this function to run you must first create
# a new API key for your application via the [Egnyte for Developers](https://developers.egnyte.com/member/register) site.
#
#

authenticate_egnyte <- function(username, password, client_id, domain, .autoset_env = TRUE) {
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

  # Upload to user's environment variables
  if (autoset_env) {
    Sys.setenv(EGNYTE_TOKEN = token_value)
  }

  # Get user info and print
  uinfo_url <- paste0(url, "pubapi/v1/userinfo")
  udata_req <- httr::GET(url = uinfo_url, httr::add_headers(Authorization = token_value))
  udata <- httr::content(udata_req, "parse")
  writeLines(paste0("Egnyte user authorized.\n\nWelcome ", udata$first_name, " ", udata$last_name, "."))

  .rs.restartR()

  token_value
}
