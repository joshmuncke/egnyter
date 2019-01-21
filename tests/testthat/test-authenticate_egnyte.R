context("test-authenticate_egnyte")

test_that("Validate client_id works", {
  expect_error(authenticate_egnyte("testuser","testpass","bad_client_id","domain"), regexp = "Egnyte client does not look valid. Should be of the form: cba97f3apst9eqzdr5hskggx")
})

test_that("Validate credentials works", {
  expect_error(authenticate_egnyte("","testpass","cba97f3apst9eqzdr5hskggx","domain"), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_egnyte(NA,"testpass","cba97f3apst9eqzdr5hskggx","domain"), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_egnyte("testuser",NA,"cba97f3apst9eqzdr5hskggx","domain"), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_egnyte("testuser",NULL,"cba97f3apst9eqzdr5hskggx","domain"), regexp = "Invalid Egnyte credentials.")
  expect_error(authenticate_egnyte("testuser","","cba97f3apst9eqzdr5hskggx","domain"), regexp = "Invalid Egnyte credentials.")
})
