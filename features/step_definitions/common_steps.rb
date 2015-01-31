Given /^Registry is unavailable$/ do
  registry_unavailable
end

Given /^system just completed syncing records$/ do
  system_completed_sync
end

Then /^sync must time out$/ do
  assert_sync_timed_out
end

Then /^sync must raise validation failed$/ do
  assert_exception_must_be_validation_failed
end

Then /^sync must raise bad request$/ do
  assert_exception_must_be_bad_request
end

Then /^sync must raise authentication failed$/ do
  assert_exception_must_be_authentication_failed
end
