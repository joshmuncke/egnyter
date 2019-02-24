#' Save authorisation details for an Egnyter user
#'
#' This function allows you to save your Egnyter authorisation token
#' (which you can get using \code{\link{authenticate_user}}) and Egnyte domain
#' to your R options which means you will not have to reference them every time you
#' use Egnyter.
#'
#' @param domain the URL of your Egnyte domain
#' @param app_key API key of your Egnyte application
#' @param username user's Egnyte username
#' @param password user's Egnyte password
#' @export
set_token <- function(domain, app_key, username, password) {
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

  token_value <- authenticate_user(domain, app_key, username, password)

  options(egnyter.auth_token = token_value)
  options(egnyter.domain = domain)

  invisible(token_value)
}

# Get Egnyter token from user options
get_parameter <- function(which_parameter = c("token", "domain")) {
  egnyter_parameter <- NA

  if(which_parameter == "token") egnyter_parameter <- getOption("egnyter.auth_token")
  if(which_parameter == "domain") egnyter_parameter <- getOption("egnyter.domain")

  egnyter_parameter
}
