Given /^partner creates a contact via EPP$/ do
  partner_creates_contact
end

Given /^partner created contacts and were already synced$/ do
  partner_creates_contact on: '2014-03-26'.to_time, handle: 'old'
  partner_creates_contact on: '2014-03-19'.to_time, handle: 'older'
  partner_creates_contact on: '2014-01-01'.to_time, handle: 'oldest'
end

When /^system syncs latest created contacts$/ do
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

When /^system syncs latest created contacts with empty request$/ do
  system_authenticated
  system_syncs_latest_created_contacts request: EMPTY_REQUEST
end

When /^system syncs latest created contacts with invalid authentication credentials$/ do
  system_authentication_failed
  system_syncs_latest_created_contacts
end

Then /^latest created contacts must be synced$/ do
  assert_create_contact_synced
end

Then /^no contacts must be synced$/ do
  assert_no_contacts_synced
end
