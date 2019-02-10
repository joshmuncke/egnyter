#' Set authentication options for an Egynte connection.
#'
#' Sets your Egnyte authentication parameters so that it is available for all `egnyter` functions.
#'
#' @param username Egnyte username. Use \link[rstudioapi]{showPrompt} to prompt for user input
#' @param password Egnyte password See \link[rstudioapi]{askForPassword} to prompt for user password input
#' @param client_id Egnyte client API key. Register through \link[https://developers.egnyte.com/member/register] to obtain
#' @param domain The top-level Egnyte domain e.g. https://mycompany.egnyte.com/
#' @param save_token Should the authentication token be saved?
#' @param save_domain Should the domain be saved?
#' @export
set_token <- function(username, password, client_id, domain, save_token = TRUE, save_domain = TRUE) {
  if(save_token) {
    if(is.na(username) | is.na(password) | is.na(client_id) | is.na(domain) | is.null(username) | is.null(password) | is.null(client_id) | is.null(domain)) stop("Egnyte authentication details must be provided", .call = FALSE)

    token_value <- authenticate_egnyte_user(username, password, client_id, domain)

    options(egnyter.auth_token = token_value)
  }

  if(save_domain) {
    if(is.na(domain) | is.null(domain)) stop("Egnyte domain must be provided", .call = FALSE)

    options(egnyter.domain = domain)
  }

  invisible()
}

#' @export
get_parameter <- function(which_parameter = c("token", "domain")) {
  egnyter_parameter <- NA

  if(which_parameter == "token") egnyter_parameter <- getOption("egnyter.auth_token")
  if(which_parameter == "domain") egnyter_parameter <- getOption("egnyter.domain")

  egnyter_parameter
}
