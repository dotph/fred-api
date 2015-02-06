require 'test_helper'

describe RequestQuery do
  describe :run do
    subject { RequestQuery.run(since: since.to_time, up_to: up_to.to_time, type: type).count }

    let(:timestamp) { '2015-02-04 1:00 PM' }
    let(:type) { RequestType::CONTACT_CREATE }

    let(:since) { '2015-02-04 7:00 AM' }
    let(:up_to) { '2015-02-04 7:00 PM' }

    before do
      create_contact  on: timestamp.to_time
    end

    context :contact_create_records do
      specify { subject.must_equal 1 }
    end

    context :register_domain_records do
      before do
        register_domain on: timestamp.to_time
        register_domain on: timestamp.to_time
      end

      let(:type) { RequestType::DOMAIN_CREATE }

      specify { subject.must_equal 2 }
    end

    context :up_to_same_as_record_timestamp do
      let(:up_to) { timestamp }

      specify { subject.must_equal 1 }
    end

    context :since_same_as_record_timestamp do
      let(:since) { timestamp }

      specify { subject.must_equal 0 }
    end

    context :up_to_after_record_timestamp do
      let(:up_to) { '2015-02-04 9:00 AM' }

      specify { subject.must_equal 0 }
    end

    context :since_before_record_timestamp do
      let(:since) { '2015-02-04 2:00 PM' }

      specify { subject.must_equal 0 }
    end
  end

  describe :group do
    subject { RequestQuery.group(records) }

    context :groups_all_records do
      let(:records) {
        [
          { 'id' => 1, 'partner' => 'alpha', 'name' => 'a', 'value' => 'a_value' },
          { 'id' => 1, 'partner' => 'alpha', 'name' => 'b', 'value' => 'b_value' },
          { 'id' => 1, 'partner' => 'alpha', 'name' => 'c', 'value' => 'c_value' },
        ]
      }

      specify { subject.count.must_equal 1 }
      specify { subject.first.must_equal({ 'partner' => 'alpha', 'a' => 'a_value', 'b' => 'b_value', 'c' => 'c_value' }) }
    end

    context :converts_dot_to_underscore do
      let(:records) {
        [ { 'id' => 1, 'partner' => 'alpha', 'name' => 'a.x', 'value' => 'a_value' } ]
      }

      specify { subject.first.must_equal({ 'partner' => 'alpha', 'a_x' => 'a_value' }) }
    end

    context :converts_to_downcase do
      let(:records) {
        [ { 'id' => 1, 'partner' => 'alpha', 'name' => 'Ax', 'value' => 'a_value' } ]
      }

      specify { subject.first.must_equal({ 'partner' => 'alpha', 'ax' => 'a_value' }) }
    end

    context :return_empty_list_if_records_empty do
      let(:records) { [] }

      specify { subject.must_be_empty }
    end
  end
end
