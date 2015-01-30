require 'test_helper'

describe RequestQuery do
  describe :run_contact_create do
    it 'returns records within the timeframe' do
      create_contact on: '2015-01-30 5:30 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time

      result.count.must_equal 1
    end

    it 'returns records with time_end same as up_to' do
      create_contact on: '2015-01-30 6:00 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time

      result.count.must_equal 1
    end

    it 'does not return records with time_begin same as since' do
      create_contact on: '2015-01-30 5:00 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time

      result.must_be_empty
    end

    it 'does not return records with time_end after up_to' do
      create_contact on: '2015-01-30 6:01 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time

      result.must_be_empty
    end

    it 'does not return records with time_begin before since' do
      create_contact on: '2015-01-30 4:59 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time

      result.must_be_empty
    end
  end

  describe :group do
    it 'groups all records' do
      records = [
        { 'id' => 1, 'partner' => 'alpha', 'name' => 'a', 'value' => 'a_value' },
        { 'id' => 1, 'partner' => 'alpha', 'name' => 'b', 'value' => 'b_value' },
        { 'id' => 1, 'partner' => 'alpha', 'name' => 'c', 'value' => 'c_value' },
      ]

      result = RequestQuery.group(records)

      result.count.must_equal 1
      result.first.must_equal({ 'partner' => 'alpha', 'a' => 'a_value', 'b' => 'b_value', 'c' => 'c_value' })
    end

    it 'converts . to _' do
      records = [
        { 'id' => 1, 'partner' => 'alpha', 'name' => 'a.x', 'value' => 'a_value' }
      ]

      result = RequestQuery.group(records)

      result.first.must_equal({ 'partner' => 'alpha', 'a_x' => 'a_value' })
    end

    it 'converts to downcase' do
      records = [
        { 'id' => 1, 'partner' => 'alpha', 'name' => 'Ax', 'value' => 'a_value' }
      ]

      result = RequestQuery.group(records)

      result.first.must_equal({ 'partner' => 'alpha', 'ax' => 'a_value' })
    end

    it 'returns empty list if records empty' do
      RequestQuery.group([]).must_be_empty
    end
  end
end
