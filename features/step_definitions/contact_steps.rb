Given /^partner creates a new contact via EPP$/ do
  partner_creates_contact
end

Given /^contact already exists in Registry$/ do
  contact_already_exists_in_registry
end

When /^system syncs latest created contacts to Registry$/ do
  system_syncs_latest_created_contacts
end

When /^system syncs latest created contacts with invalid field values$/ do
  system_syncs_latest_created_contacts request: INVALID_REQUEST_VALUES
end

Then /^response from Registry is success$/ do
  assert_create_contact_synced
end
