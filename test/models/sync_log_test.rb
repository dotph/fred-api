require 'test_helper'

describe SyncLog do
  describe :last_run do
    it 'returns latest timestamp' do
      SyncLog.create since: '2015-01-06 2:57 PM'.to_time, until: '2015-01-06 2:58 PM'.to_time
      SyncLog.create since: '2015-01-06 2:58 PM'.to_time, until: '2015-01-06 2:59 PM'.to_time
      SyncLog.create since: '2015-01-06 2:59 PM'.to_time, until: '2015-01-06 3:00 PM'.to_time

      SyncLog.last_run.must_equal '2015-01-06 3:00 PM'.to_time
    end

    it 'returns current time if no existing records' do
      current_time = Time.now

      SyncLog.last_run(current_time: current_time).must_equal current_time
    end
  end

  describe :aliases do
    subject { SyncLog.new(until: Time.now) }

    specify { subject.up_to.must_equal subject.until }
  end
end
