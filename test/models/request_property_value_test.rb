require 'test_helper'

describe RequestPropertyValue do
  describe :associations do
    before do
      @request_property_value = create :request_property_value
    end

    it 'belongs to request' do
      @request_property_value.request.wont_be_nil
    end

    it 'belongs to request_property_name' do
      @request_property_value.request_property_name.wont_be_nil
    end
  end
end
