class Request < ActiveRecord::Base
  self.table_name = 'request'

  belongs_to  :request_type

  has_many :request_property_values

  def self.latest_time current_time: Time.now
    latest_record = order(time_end: :desc).first

    latest_record ? latest_record.time_end : current_time
  end
end
