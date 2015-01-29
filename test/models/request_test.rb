require 'test_helper'

describe Request do
  describe :associations do
    before do
      @request = create :request
    end

    it 'belongs to request_type' do
      @request.request_type.wont_be_nil
    end
  end
end
