def partner_registers_domain on: Time.now, name: 'test.ph'
  register_domain on: on, name: name
end

def system_syncs_latest_registered_domains request: VALID_CREATE_REQUEST
  sync_records  to: orders_url,
                command: proc { |since, up_to| RegisterDomain.sync since: since, up_to: up_to },
                request: request
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

def assert_no_domains_synced
  assert_no_exception_thrown

  assert_not_requested :post, orders_url
end
