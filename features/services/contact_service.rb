def contact_url
  REGISTRY_URL + '/contacts'
end

def partner_creates_contact handle: 'contact_handle', on: Time.now
  create_contact handle: handle, on: on
end

def system_syncs_latest_created_contacts request: VALID_CREATE_REQUEST
  registry_response = REGISTRY_RESPONSES[request]

  stub_request(:post, contact_url)
    .with(headers: default_headers)
    .to_return(status: registry_response[:status], body: registry_response[:body].to_json) unless @registry_unavailable

  begin
    CreateContact.sync since: nil, up_to: nil
  rescue => e
    @exception_thrown = e
  end
end

def assert_create_contact_synced
  assert_requested :post, contact_url,
                          body: create_contact_request.to_json,
                          times: 1
end

def assert_no_contacts_synced
  assert_not_requested :post, contact_url
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
