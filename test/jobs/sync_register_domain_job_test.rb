require 'test_helper'

describe SyncRegisterDomainJob do
  describe :perform_later do
    it 'POSTs a new order' do
      stub_request(:post, authorizations_path).to_return(status: 201, body: {token: 'ABCDEF'}.to_json)
      stub_request(:post, SyncRegisterDomainJob::PATH).to_return(status: 201)

      json_request = {
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

      domain = RegisterDomain.new partner: 'alpha',
                                  domain: 'test.ph',
                                  period: 1,
                                  registrant_handle: 'contact_handle'

      perform_enqueued_jobs do
        SyncRegisterDomainJob.perform_later domain.as_json
      end

      credentials = {
        username: Rails.configuration.x.registry_username,
        password: Rails.configuration.x.registry_password
      }

      assert_requested :post, authorizations_path, body: credentials.to_json, times: 1

      assert_requested :post, SyncRegisterDomainJob::PATH,
                              headers: { 'Authorization' => 'Token token="ABCDEF"' },
                              body: json_request.to_json,
                              times: 1
    end
  end
end
