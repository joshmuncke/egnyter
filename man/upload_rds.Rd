% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/upload_file.R
\name{upload_rds}
\alias{upload_rds}
\title{Upload an RDS file to Egnyte}
\usage{
upload_rds(object, dest, token = egnyter::get_parameter("token"),
  domain = egnyter::get_parameter("domain"))
}
\arguments{
\item{object}{The object to be saved}

\item{dest}{The remote Egnyte file path you want to upload to}

\item{token}{User's Egnyter authorisation token}

\item{domain}{Egnyte domain URL}
}
\description{
This function saves a local object as an RDS file and uploads it to a specified Egnyte directory.
Object to RDS conversion is done using \code{\link[base]{saveRDS}}.
}
