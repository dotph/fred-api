require 'test_helper'

describe SyncLog do
  describe :last_run do
    subject { SyncLog.last_run current_time: current_time }

    let(:current_time) { Time.now }

    context :returns_latest_timestamp do
      before do
        SyncLog.create since: '2015-01-06 2:57 PM'.to_time, until: '2015-01-06 2:58 PM'.to_time
        SyncLog.create since: '2015-01-06 2:58 PM'.to_time, until: '2015-01-06 2:59 PM'.to_time
        SyncLog.create since: '2015-01-06 2:59 PM'.to_time, until: '2015-01-06 3:00 PM'.to_time
      end

      specify { subject.must_equal '2015-01-06 3:00 PM'.to_time }
    end

    context :returns_current_time_if_no_existing_records do
      specify { subject.must_equal current_time }
    end
  end

  describe :aliases do
    subject { SyncLog.new(until: Time.now) }

    specify { subject.up_to.must_equal subject.until }
  end
end
