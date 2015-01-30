REGISTRY_URL = 'http://registry.host'

REGISTRY_RESPONSES = {
  ok:                 { status: 200, body: {} },
  created:            { status: 201, body: {} },
  validation_failed:  { status: 422, body: { message: 'Validation Failed' } }
}

VALID_CREATE_REQUEST = :created
INVALID_REQUEST_VALUES = :validation_failed

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
