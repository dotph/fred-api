Given /^partner registers a domain via EPP$/ do
  partner_registers_domain
end

When /^system syncs latest registered domains$/ do
  system_authenticated
  system_syncs_latest_registered_domains
end

Then /^latest registered domains must be synced$/ do
  assert_register_domain_synced
end
