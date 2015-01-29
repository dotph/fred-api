require 'test_helper'

describe Request do
  describe :associations do
    before do
      @request = create :request
    end

    it 'belongs to request_type' do
      @request.request_type.wont_be_nil
    end

    it 'has many request_property_value' do
      create :request_property_value, request: @request
      create :request_property_value, request: @request

      @request.request_property_values.wont_be_empty
    end
  end
end
