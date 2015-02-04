require 'test_helper'

describe CreateContact do
  describe :all do
    subject { CreateContact.all since: since, up_to: up_to }

    before do
      create_contact on: current_time + 1.minute
    end

    context :contacts_match do
      let(:current_time) { Time.now }
      let(:since) { current_time }
      let(:up_to) { current_time + 1.minute }

      specify { subject.count.must_equal 1 }
      specify { subject.first.partner.must_equal 'alpha' }
      specify { subject.first.partner.must_equal 'alpha' }
      specify { subject.first.handle.must_equal 'contact_handle' }
      specify { subject.first.name.must_equal 'value' }
      specify { subject.first.organization.must_be_nil }
      specify { subject.first.street.must_equal 'value' }
      specify { subject.first.city.must_equal 'value' }
      specify { subject.first.state.must_be_nil }
      specify { subject.first.postal_code.must_equal 'value' }
      specify { subject.first.country_code.must_equal 'value' }
      specify { subject.first.phone.must_be_nil }
      specify { subject.first.email.must_equal 'value' }
    end

    context :no_contacts_match do
      let(:since) { Time.now }
      let(:up_to) { Time.now }

      specify { subject.must_be_empty }
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
