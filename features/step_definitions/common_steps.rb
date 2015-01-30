Given /^Registry is unavailable$/ do
  registry_unavailable
end

Then /^sync must time out$/ do
  assert_exception_must_be_timed_out
end
