def registry_unavailable
  @registry_unavailable = true

  WebMock.allow_net_connect!
end

def assert_exception_must_be_timed_out
  @exception_thrown.message.must_include 'getaddrinfo'
end
