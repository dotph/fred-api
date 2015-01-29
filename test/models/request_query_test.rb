require 'test_helper'

describe RequestQuery do
  describe :run_contact_create do
    it 'returns records' do
      create_contact

      result = RequestQuery.run

      result.count.must_equal 1
    end
  end

  describe :group do
    it 'groups all records' do
      records = [
        { 'id' => 1, 'name' => 'a', 'value' => 'a_value' },
        { 'id' => 1, 'name' => 'b', 'value' => 'b_value' },
        { 'id' => 1, 'name' => 'c', 'value' => 'c_value' },
      ]

      result = RequestQuery.group(records)

      result.count.must_equal 1
      result.first.must_equal({ 'a' => 'a_value', 'b' => 'b_value', 'c' => 'c_value' })
    end

    it 'converts . to _' do
      records = [
        { 'id' => 1, 'name' => 'a.x', 'value' => 'a_value' }
      ]

      result = RequestQuery.group(records)

      result.first.must_equal({ 'a_x' => 'a_value' })
    end

    it 'converts to downcase' do
      records = [
        { 'id' => 1, 'name' => 'Ax', 'value' => 'a_value' }
      ]

      result = RequestQuery.group(records)

      result.first.must_equal({ 'ax' => 'a_value' })
    end

  end
end
