def contact_url
  REGISTRY_URL + '/contacts'
end

def partner_creates_contact
  create_contact
end

def system_syncs_latest_created_contacts request: VALID_CREATE_REQUEST
  registry_response = REGISTRY_RESPONSES[request]

  stub_request(:post, contact_url)
    .to_return(status: registry_response[:status], body: registry_response[:body].to_json) unless @registry_unavailable

  begin
    CreateContact.sync
  rescue => e
    @exception_thrown = e
  end
end

def assert_create_contact_synced
  assert_requested :post, contact_url,
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
