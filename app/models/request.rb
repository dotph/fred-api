class Request < ActiveRecord::Base
  self.table_name = 'request'

  belongs_to  :request_type
end
