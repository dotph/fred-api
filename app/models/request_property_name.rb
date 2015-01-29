class RequestPropertyName < ActiveRecord::Base
  self.table_name = 'request_property_name'

  has_many :request_property_values, foreign_key: :property_name_id
end
