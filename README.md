
<!-- README.md is generated from README.Rmd. Please edit that file -->
egnyter
=======

<<<<<<< HEAD
The `egnyter` package allows for seamless usage of Egnyte-based corporate filesharing systems from within R.
=======
The `egnyter` package allows for seamless useage of Egnyte-based corporate filesharing systems from within R.
>>>>>>> 0d43f8e2641c3a5544d3f0850281206950672c8d

For data scientists and analysts at companies that use Egnyte this will allow transfer of datasets and R objects without needing to create local copies or clones of the files. This has the pleasant side-effect of making code more reproducible since datasets can be referenced in their direct Egnyte location as opposed to a local user repository.

`egnyter` supports pipe-ing (through the `magrittr` pipe `%>%`) for interoperability with the [`tidyverse`](https://www.tidyverse.org/) suite of packages.

Installation
------------

You can install `egnyter` from Github using the following command:

``` r
# You must have devtools installed first
devtools::install_github("deathbydata/egnyter")
```

Setup
-----

### Registering an API key (do once)

Before you can use `egnyter` you are required to create a client API key. This process can be done easily on the [Egnyte for Developers](https://developers.egnyte.com/member/register) page.

When you register your application you should select "Internal Application (own company use only)" in the "Type" dropdown box.

This API key can be shared to analysts and data scientists who will be using `egnyter`.

### Creating a token (do for every user)

Once you have a token you will be able to authenticate yourself via `egnyter` to allow file transfers. To do this use the following code:

``` r
egnyter::set_token(username = "your egnyte username",
                   password = "your egnyte password",
                   client_id = "your internal application API key",
                   domain = "your custom egnyte domain") # Typically https://<yourcompanyname>.egnyte.com
```

Usage
-----

### Downloading

### Uploading
