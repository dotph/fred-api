def partner_creates_contact handle: 'contact_handle', on: Time.now
  create_contact handle: handle, on: on
end

def system_syncs_latest_created_contacts request: VALID_CREATE_REQUEST
  sync_records  to: contacts_url,
                command: proc { |since, up_to| CreateContact.sync since: since, up_to: up_to },
                request: request
end

def assert_create_contact_synced
  assert_no_exception_thrown

  assert_requested :post, contacts_url,
                          body: create_contact_request.to_json,
                          times: 1
end

def assert_no_contacts_synced
  assert_no_exception_thrown

  assert_not_requested :post, contacts_url
end

def create_contact_request
  {
    partner: 'alpha',
    handle: 'contact_handle',
    name: 'value',
    organization: nil,
    street: 'value',
    city: 'value',
    state: nil,
    postal_code: 'value',
    country_code: 'value',
    phone: nil,
    email: 'value'
  }
end
