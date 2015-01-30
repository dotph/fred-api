Given /^partner creates a new contact via EPP$/ do
  partner_creates_contact
end

When /^system syncs latest created contacts to Registry$/ do
  system_authenticated
  system_syncs_latest_created_contacts
end

When /^system syncs latest created contacts with invalid field values$/ do
  system_authenticated
  system_syncs_latest_created_contacts request: INVALID_REQUEST_VALUES
end

When /^system syncs latest created contacts with incomplete fields$/ do
  system_authenticated
  system_syncs_latest_created_contacts request: INCOMPLETE_FIELDS
end

Then /^response from Registry is success$/ do
  assert_create_contact_synced
end
