class RequestType < ActiveRecord::Base
  CONTACT_CREATE = 'ContactCreate'

  self.table_name = 'request_type'
end
