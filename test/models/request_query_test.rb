require 'test_helper'

describe RequestQuery do
  describe :run do
    it 'returns ContactCreate records' do
      create_contact

      result = RequestQuery.run

      result.wont_be_empty
      result.count.must_equal 2
    end
  end
end
