require 'test_helper'

describe RequestPropertyName do
  describe :associations do
    before do
      @request_property_name = create :request_property_name
    end

    it 'has many request_property_values' do
      create :request_property_value, request_property_name: @request_property_name
      create :request_property_value, request_property_name: @request_property_name

      @request_property_name.request_property_values.wont_be_empty
    end
  end
end
