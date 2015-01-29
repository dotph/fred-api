class RequestPropertyValue < ActiveRecord::Base
  self.table_name = 'request_property_value'

  belongs_to :request
  belongs_to :request_property_name, foreign_key: :property_name_id
end
