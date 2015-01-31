Given /^partner registers a domain via EPP$/ do
  partner_registers_domain
end

When /^system syncs latest registered domains$/ do
  system_authenticated
  system_syncs_latest_registered_domains
end

When /^system syncs latest registered domains with invalid field values$/ do
  system_authenticated
  system_syncs_latest_registered_domains request: INVALID_REQUEST_VALUES
end

When /^system syncs latest registered domains with incomplete fields$/ do
  system_authenticated
  system_syncs_latest_registered_domains request: INCOMPLETE_FIELDS
end

When /^system syncs latest registered domains with empty request$/ do
  system_authenticated
  system_syncs_latest_registered_domains request: EMPTY_REQUEST
end

When /^system syncs latest registered domains with invalid authentication credentials$/ do
  system_authentication_failed
  system_syncs_latest_registered_domains
end

Then /^latest registered domains must be synced$/ do
  assert_register_domain_synced
end
