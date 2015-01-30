require 'test_helper'

describe SyncCreateContactJob do
  describe :perform_later do
    it 'POSTs a new contact' do
      create_contact 

      #stub_request(:post, authorizations_path).to_return(status: 201, body: {token: 'ABCDEF'}.to_json)
      stub_request(:post, SyncCreateContactJob::PATH).to_return(status: 201)

      json_request = {
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

      contacts = CreateContact.all  since: '2015-01-07 4:00 PM'.to_time,
                                    up_to: '2015-01-07 4:20 PM'.to_time


      perform_enqueued_jobs do
        SyncCreateContactJob.perform_later contacts.first.as_json
      end

      #credentials = {
         #username: Rails.configuration.x.registry_username,
         #password: Rails.configuration.x.registry_password
      #}
      #assert_requested :post, authorizations_path, body: credentials.to_json, times: 1


      assert_requested  :post,
                        SyncCreateContactJob::PATH,
                        headers: { 'Content-Type' => 'application/json' },
                        body: json_request.to_json, times: 1
    end
  end
end
