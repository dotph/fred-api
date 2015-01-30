Given /^Registry is unavailable$/ do
  registry_unavailable
end

Then /^sync must time out$/ do
  assert_exception_must_be_timed_out
end

Then /^response from Registry must be validation failure$/ do
  assert_exception_must_be_validation_failed
end
