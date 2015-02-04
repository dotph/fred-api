require 'test_helper'

describe CreateContact do
  describe :all do
    subject { CreateContact.all(since: since, up_to: up_to).first }

    before do
      create_contact on: current_time + 1.minute
    end

    let(:current_time) { Time.now }

    context :contacts_match do
      let(:since) { current_time }
      let(:up_to) { current_time + 1.minute }

      specify { subject.wont_be_nil }
      specify { subject.partner.must_equal 'alpha' }
      specify { subject.partner.must_equal 'alpha' }
      specify { subject.handle.must_equal 'contact_handle' }
      specify { subject.name.must_equal 'value' }
      specify { subject.organization.must_be_nil }
      specify { subject.street.must_equal 'value' }
      specify { subject.city.must_equal 'value' }
      specify { subject.state.must_be_nil }
      specify { subject.postal_code.must_equal 'value' }
      specify { subject.country_code.must_equal 'value' }
      specify { subject.phone.must_be_nil }
      specify { subject.email.must_equal 'value' }
    end

    context :no_contacts_match do
      let(:since) { Time.now }
      let(:up_to) { Time.now }

      specify { subject.must_be_nil }
    end
  end

  describe :aliases do
    subject {
      CreateContact.new name: 'name',
                        street: 'street',
                        city: 'city',
                        postal_code: 'postal_code',
                        country_code: 'country_code'
    }

    specify { subject.pi_name.must_equal subject.name }
    specify { subject.pi_street.must_equal subject.street }
    specify { subject.pi_city.must_equal subject.city }
    specify { subject.pi_postalcode.must_equal subject.postal_code }
    specify { subject.pi_countrycode.must_equal subject.country_code }
  end

  describe :as_json do
    subject {
      CreateContact.new partner: 'alpha',
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

    let(:expected_json) {
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
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
