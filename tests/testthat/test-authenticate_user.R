context("test-authenticate_user.R")

test_that("Validate client_id works", {
  expect_error(authenticate_user("https://validdomain.egnyter.com","bad_client_id","testuser","testpass"), regexp = "Egnyte application key does not look valid. Should be of the form: cba97f3apst9eqzdr5hskggx")
})

test_that("Validate credentials works", {
  expect_error(authenticate_user("https://validdomain.egnyter.com","cba97f3apst9eqzdr5hskggx","","testpass"), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_user("https://validdomain.egnyter.com","cba97f3apst9eqzdr5hskggx",NA,"testpass"), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_user("https://validdomain.egnyter.com","cba97f3apst9eqzdr5hskggx","testuser",NA), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_user("https://validdomain.egnyter.com","cba97f3apst9eqzdr5hskggx","testuser",NULL), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_user("https://validdomain.egnyter.com","cba97f3apst9eqzdr5hskggx","testuser",""), regexp = "Invalid Egnyte credentials.")
})

test_that("Validate domain validation", {
  expect_error(authenticate_user("invaliddomain","cba97f3apst9eqzdr5hskggx","","testpass"), regexp = "Invalid Egnyte domain.")
  expect_error(authenticate_user("www.notvalid","cba97f3apst9eqzdr5hskggx","","testpass"), regexp = "Invalid Egnyte domain.")
})
