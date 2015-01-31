Given /^Registry is unavailable$/ do
  registry_unavailable
end

Given /^system just completed syncing records$/ do
  system_completed_sync
end

Then /^sync must time out$/ do
  assert_sync_timed_out
end

Then /^response from Registry must be validation failed$/ do
  assert_exception_must_be_validation_failed
end

Then /^response from Registry must be bad request$/ do
  assert_exception_must_be_bad_request
end
