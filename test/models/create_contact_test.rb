require 'test_helper'

describe CreateContact do
  describe :all do
    it 'returns all new contacts' do
      create_contact

      result = CreateContact.all

      result.count.must_equal 1
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
end
