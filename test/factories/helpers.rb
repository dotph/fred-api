def create_contact handle: 'contact_handle', on: Time.now
  request = create :contact_create_request, time_begin: on, time_end: on

  create_property request: request, name: 'handle',   value: handle
  create_property request: request, name: 'rc',       value: 1000
  create_property request: request, name: 'msg',      value: 'Command completed successfully'

  ['pi.name', 'pi.street', 'pi.city', 'pi.postalCode', 'pi.countryCode', 'email'].each do |name|
    create_property request: request, name: name,  value: 'value'
  end

end

def create_property name:, value:, request:
  property_name = create :request_property_name, name: name

  create :request_property_value, request: request,
                                  request_property_name: property_name,
                                  value: value
end
