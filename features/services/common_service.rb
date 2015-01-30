REGISTRY_URL = Rails.configuration.x.registry_url
AUTHORIZATION_URL = REGISTRY_URL + '/authorizations'

REGISTRY_RESPONSES = {
  ok:                 { status: 200, body: {} },
  created:            { status: 201, body: {} },
  bad_request:        { status: 400, body: { message: 'Bad Request' } },
  validation_failed:  { status: 422, body: { message: 'Validation Failed' } }
}

VALID_CREATE_REQUEST    = :created
INVALID_REQUEST_VALUES  = :validation_failed
INCOMPLETE_FIELDS       = :bad_request
EMPTY_REQUEST           = :bad_request

def system_authenticated
  stub_request(:post, AUTHORIZATION_URL).to_return(status: 201, body: { token: 'ABCDEF' }.to_json)
end

def default_headers
  {
    'Content-Type' => 'application/json',
    'Authorization' => 'Token token="ABCDEF"'
  }
end

def registry_unavailable
  @registry_unavailable = true

  WebMock.allow_net_connect!
end

def assert_exception_must_be_timed_out
  @exception_thrown.message.must_include 'getaddrinfo'
end

def assert_exception_must_be_validation_failed
  @exception_thrown.message.must_equal 'Code: 422, Message: {"message":"Validation Failed"}'
end

def assert_exception_must_be_bad_request
  @exception_thrown.message.must_equal 'Code: 400, Message: {"message":"Bad Request"}'
end
