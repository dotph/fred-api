class RequestType < ActiveRecord::Base
  CONTACT_CREATE  = 'ContactCreate'
  DOMAIN_CREATE   = 'DomainCreate'

  self.table_name = 'request_type'
end
