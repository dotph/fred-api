require 'test_helper'

describe Request do
  describe :associations do
    subject { create :request }

    before do
      create :request_property_value, request: subject
      create :request_property_value, request: subject
    end

    specify { subject.request_type.wont_be_nil }
    specify { subject.request_property_values.wont_be_nil }
  end

  describe :latest_time do
    subject { Request.latest_time current_time: current_time }

    let(:current_time) { Time.now }

    context :returns_latest_audit_time do
      before do
        create_contact on: '2015-01-30 5:26 PM'.to_time
        create_contact on: '2015-01-30 5:27 PM'.to_time
        create_contact on: '2015-01-30 5:28 PM'.to_time
      end

      specify { subject.must_equal '2015-01-30 5:28 PM'.to_time }
    end

    context :returns_current_time_if_no_existing_records do
      specify { subject.must_equal current_time }
    end
  end
end
