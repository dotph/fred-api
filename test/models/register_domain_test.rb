require 'test_helper'

describe RegisterDomain do
  describe :all do
    subject {
      RegisterDomain.all  since: current_time,
                          up_to: current_time + 1.minute
    }

    let(:current_time) { Time.now }

    before do
      register_domain on: current_time + 1.minute
    end

    specify { subject.count.must_equal 1 }
    specify { subject.first.partner.must_equal 'alpha' }
    specify { subject.first.domain.must_equal 'test.ph' }
    specify { subject.first.period.must_equal 1 }
    specify { subject.first.registrant_handle.must_equal 'contact_handle' }
  end

  describe :as_json do
    subject {
      RegisterDomain.new  partner: 'alpha',
                          domain: 'test.ph',
                          period: 1,
                          registrant_handle: 'contact_handle'
    }

    let(:expected_json) {
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
    }

    specify { subject.as_json.must_equal expected_json }
  end

  describe :aliases do
    subject {
      RegisterDomain.new  domain: 'domain',
                          registrant_handle: 'handle'
    }

    specify { subject.handle.must_equal subject.domain }
    specify { subject.registrant.must_equal subject.registrant_handle }
  end
end
