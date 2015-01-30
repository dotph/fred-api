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

  describe :latest_time do
    it 'returns latest audit_time' do
      create_contact on: '2015-01-30 5:26 PM'.to_time
      create_contact on: '2015-01-30 5:27 PM'.to_time
      create_contact on: '2015-01-30 5:28 PM'.to_time

      Request.latest_time.must_equal '2015-01-30 5:28 PM'.to_time
    end

    it 'returns current time if no existing records' do
      current_time = Time.now

      Request.latest_time(current_time: current_time).must_equal current_time
    end
  end
end
