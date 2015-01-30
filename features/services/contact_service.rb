def partner_creates_contact
  create_contact
end

def system_syncs_latest_created_contacts
  stub_request(:post, 'http://example.org/contacts')
    .with(body: create_contact_request.to_json)
    .to_return  status: 201,
                body: {}.to_json

  CreateContact.sync
end

def assert_create_contact_synced
  assert_requested :post, 'http://example.org/contacts',
                          body: create_contact_request.to_json,
                          times: 1
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
