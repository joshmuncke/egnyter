#' Upload a local file to Egnyte
#'
#' This function uploads a local file directly to a specified remote Egnyte directory. This function can
#' be used to upload a local file of any kind directly to Egnyte. It can also be used to implement additional helper
#' functions e.g. \code{\link{upload_csv}} for specific file type uploads.
#'
#' @param file Path to a local file
#' @param dest Remote Egnyte directory destination
#' @param token User's Egnyter authorisation token
#' @param domain Egnyte domain URL
#' @export
upload_file <- function(file, dest, token = get_parameter("token"), domain = get_parameter("domain")) {
  # Check if file exists
  if(!file.exists(file)) stop("Invalid file path.", call. = FALSE)

  # Check domain
  if(!egnyter:::validate_domain(domain)) stop("Invalid Egnyte domain.", call. = FALSE)

  # Check authorisation token
  if(!egnyter:::validate_token(token)) stop("Invalid Egnyte token.", call. = FALSE)

  # Add a trailing '/' if not given
  if(stringr::str_sub(domain, -1) != "/") domain <- paste0(domain,"/")

  # Replace whitespace in destination folder path
  dest <- stringr::str_replace_all(dest, " ", "%20")

  # Formatted upload path
  upload_path <- paste0(domain, "pubapi/v1/fs-content/", dest)

  # Upload request
  upload_req <- httr::POST(url = upload_path, httr::add_headers(Authorization = token), body = httr::upload_file(file))
  httr::stop_for_status(upload_req)

  invisible()
}


#' Upload a csv file to Egnyte
#'
#' This function converts a local data frame into a csv file and uploads it to a specified Egnyte directory.
#' Data frame to csv file conversion is done using \code{\link[readr]{write_csv}}.
#'
#' @param x A data frame to upload to Egnyte
#' @param dest The remote Egnyte folder you want to upload to
#' @param token User's Egnyter authorisation token
#' @param domain Egnyte domain URL
#' @param ... Additional arguments to be passed to `write_csv`
#' @export
upload_csv <- function(x, dest, token = egnyter::get_parameter("token"), domain = egnyter::get_parameter("domain"), ...) {
  # This function will only work for data frame
  stopifnot(is.data.frame(x))

  # Write to temp csv file
  tmp_name <- tempfile(fileext = ".csv")
  readr::write_csv(x = x, path = tmp_name, ...)

  # Upload request
  egnyter::upload_file(tmp_name, dest, token, domain)

  # Delete temp file
  file.remove(tmp_name)

  # Return x invisibly
  invisible(x)
}

#' Upload a feather file to Egnyte
#'
#' This function converts a local data frame into a feather file and uploads it to a specified Egnyte directory.
#' Data frame to feather file conversion is done using \code{\link[feather]{write_feather}}.
#'
#' @param x A data frame to upload to Egnyte
#' @param dest The remote Egnyte folder you want to upload to
#' @param token User's Egnyter authorisation token
#' @param domain Egnyte domain URL
#' @param ... Additional arguments to be passed to `write_feather`
#' @export
upload_feather <- function(x, dest, token = egnyter::get_parameter("token"), domain = egnyter::get_parameter("domain"), ...) {
  # This function will only work for data frame
  stopifnot(is.data.frame(x))

  # Write to temp feather file
  tmp_name <- tempfile(fileext = ".feather")
  feather::write_feather(x = x, path = tmp_name, ...)

  # Upload request
  egnyter::upload_file(tmp_name, dest, token, domain)

  # Delete temp file
  file.remove(tmp_name)

  # Return x invisibly
  invisible(x)
}

#' Upload an RData file to Egnyte
#'
#' This function saves a local object as an RData file and uploads it to a specified Egnyte directory.
#' Object to RData conversion is done using \code{\link[base]{save}}.
#'
#' @param x A local object to upload to Egnyte
#' @param dest The remote Egnyte folder you want to upload to
#' @param token User's Egnyter authorisation token
#' @param domain Egnyte domain URL
#' @param ... Additional arguments to be passed to `save`
#' @export
upload_rdata <- function(x, dest, token = egnyter::get_parameter("token"), domain = egnyter::get_parameter("domain"), ...) {
  # Write to temp RData file
  tmp_name <- tempfile(fileext = ".RData")
  save(x, file = tmp_name, ...)

  # Upload request
  egnyter::upload_file(tmp_name, dest, token, domain)

  # Delete temp file
  file.remove(tmp_name)

  # Return x invisibly
  # Does this make sense for a non-dataframe?
  invisible(x)
}
