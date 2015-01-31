def partner_registers_domain
  register_domain
end

def system_syncs_latest_registered_domains request: VALID_CREATE_REQUEST
  registry_response = REGISTRY_RESPONSES[request]

  stub_request(:post, orders_url)
    .with(headers: default_headers)
    .to_return(status: registry_response[:status], body: registry_response[:body].to_json) unless @registry_unavailable

  since = SyncLog.last_run
  up_to = Request.latest_time

  begin
    RegisterDomain.sync since: since, up_to: up_to
  rescue => e
    @exception_thrown = e
  ensure
    SyncLog.create since: since, until: up_to
  end
end

def assert_register_domain_synced
  assert_no_exception_thrown

  assert_requested :post, orders_url,
                          body: register_domain_request.to_json,
                          times: 1
end

def register_domain_request
  {
    partner: 'alpha',
    currency_code: 'USD',
    order_details: [
      {
        type: 'domain_create',
        domain: 'test.ph',
        period: 1,
        registrant_handle: 'contact_handle'
      }
    ]
  }
end
