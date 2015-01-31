require 'test_helper'

describe RegisterDomain do
  describe :all do
    it 'returns all new registered domains' do
      current_time = Time.now

      register_domain on: current_time + 1.minute

      result = RegisterDomain.all since: current_time,
                                  up_to: current_time + 1.minute

      result.count.must_equal 1

      order = result.first
      order.partner.must_equal 'alpha'
      order.domain.must_equal 'test.ph'
      order.period.must_equal 1
      order.registrant_handle.must_equal 'contact_handle'
    end
  end

  describe :as_json do
    it 'converts to JSON' do
      expected_json = {
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

      record = RegisterDomain.new partner: 'alpha',
                                  domain: 'test.ph',
                                  period: 1,
                                  registrant_handle: 'contact_handle'

      record.as_json.must_equal expected_json
    end
  end

  describe :aliases do
    it 'aliases domain as handle' do
      RegisterDomain.new(domain: 'value').handle.must_equal 'value'
    end

    it 'aliases registrant_handle as registrant' do
      RegisterDomain.new(registrant_handle: 'value').registrant.must_equal 'value'
    end
  end
end
