class SyncLog < ActiveRecord::Base
  def self.last_run current_time: Time.now
    latest_record = order(until: :desc).first

    latest_record ? latest_record.until.to_time : current_time
  end
end
