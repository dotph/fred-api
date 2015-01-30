require 'test_helper'

describe CreateContact do
  describe :all do
    it 'returns all new contacts' do
      current_time = Time.now

      create_contact on: current_time + 1.minute

      result = CreateContact.all  since: current_time,
                                  up_to: current_time + 1.minute

      result.count.must_equal 1

      contact = result.first
      contact.partner.must_equal 'alpha'
      contact.handle.must_equal 'contact_handle'
      contact.name.must_equal 'value'
      contact.organization.must_be_nil
      contact.street.must_equal 'value'
      contact.city.must_equal 'value'
      contact.state.must_be_nil
      contact.postal_code.must_equal 'value'
      contact.country_code.must_equal 'value'
      contact.phone.must_be_nil
      contact.email.must_equal 'value'
    end

    it 'returns empty list if no contacts found' do
      result = CreateContact.all since: Time.now, up_to: Time.now

      result.must_be_empty
    end
  end

  describe :aliases do
    it 'aliases name as pi_name' do
      CreateContact.new(name: 'value').pi_name.must_equal 'value'
    end

    it 'aliases street as pi_street' do
      CreateContact.new(street: 'value').pi_street.must_equal 'value'
    end

    it 'aliases city as pi_city' do
      CreateContact.new(city: 'value').pi_city.must_equal 'value'
    end

    it 'aliases postal_code as pi_postalcode' do
      CreateContact.new(postal_code: 'value').pi_postalcode.must_equal 'value'
    end

    it 'aliases country_code as pi_countrycode' do
      CreateContact.new(country_code: 'value').pi_countrycode.must_equal 'value'
    end
  end

  describe :as_json do
    it 'converts to JSON' do
      expected_json = {
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

      create_contact = CreateContact.new  partner: 'alpha',
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

      create_contact.as_json.must_equal expected_json
    end
  end
end
