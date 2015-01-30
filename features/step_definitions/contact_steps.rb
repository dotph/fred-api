Given /^partner creates a new contact via EPP$/ do
  partner_creates_contact
end

When /^system syncs latest created contacts to Registry$/ do
  system_syncs_latest_created_contacts
end

Then /^response from Registry is success$/ do
  assert_create_contact_synced
end
