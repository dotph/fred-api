require 'test_helper'

describe RequestQuery do
  describe :run do
    before do
      @current_time = Time.now
      @create_time  = @current_time + 1.minute

      create_contact  on: @create_time
      register_domain on: @create_time
      register_domain on: @create_time
    end

    it 'returns contact_create requests' do
      result = RequestQuery.run since: @current_time,
                                up_to: @create_time,
                                type: RequestType::CONTACT_CREATE

      result.count.must_equal 1
    end

    it 'returns contact_create requests' do
      result = RequestQuery.run since: @current_time,
                                up_to: @create_time,
                                type: RequestType::DOMAIN_CREATE

      result.count.must_equal 2
    end

    it 'returns records with time_end same as up_to' do
      create_contact on: '2015-01-30 6:00 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time,
                                type:  RequestType::CONTACT_CREATE

      result.count.must_equal 1
    end

    it 'does not return records with time_begin same as since' do
      create_contact on: '2015-01-30 5:00 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time,
                                type:  RequestType::CONTACT_CREATE

      result.must_be_empty
    end

    it 'does not return records with time_end after up_to' do
      create_contact on: '2015-01-30 6:01 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time,
                                type:  RequestType::CONTACT_CREATE

      result.must_be_empty
    end

    it 'does not return records with time_begin before since' do
      create_contact on: '2015-01-30 4:59 PM'.to_time

      result = RequestQuery.run since: '2015-01-30 5:00 PM'.to_time,
                                up_to: '2015-01-30 6:00 PM'.to_time,
                                type:  RequestType::CONTACT_CREATE

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
