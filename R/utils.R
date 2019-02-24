#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

# Validation of egnyte filesystem domains
validate_domain <- function(domain) {
  stringr::str_detect(domain, 'https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)')
}

# Validate format of authorisation/bearer token
validate_token <- function(token) {
  stringr::str_detect(token, 'Bearer [a-z0-9]{24}')
}
