class RequestPropertyValue < ActiveRecord::Base
  self.table_name = 'request_property_value'

  belongs_to :request
end
