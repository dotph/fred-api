class FRED
  def self.create_contact handle, partner: 'alpha'
    request = create_request request_type: contact_create_request, partner: partner

    create_property request: request, name: 'handle',   value: handle
    create_property request: request, name: 'partner',  value: partner
    create_property request: request, name: 'rc',       value: 1000
    create_property request: request, name: 'msg',      value: 'Command completed successfully'

    ['pi.name', 'pi.street', 'pi.city', 'pi.postalCode', 'pi.countryCode', 'email'].each do |name|
      create_property request: request, name: name,  value: 'value'
    end
  end

  private

  def self.create_request partner:, request_type:
    Request.create  time_begin: Time.now,
                    time_end:   Time.now,
                    service_id: -1,
                    request_type: request_type,
                    user_name:  partner
  end

  def self.contact_create_request
    unless RequestType.exists?(name: RequestType::CONTACT_CREATE)
      RequestType.create name: RequestType::CONTACT_CREATE, service_id: -1
    end

    RequestType.find_by(name: RequestType::CONTACT_CREATE)
  end

  def self.create_property name:, value:, request:
    property_name = RequestPropertyName.create name: name

    RequestPropertyValue.create request_time_begin:     Time.now,
                                request_service_id:     -1,
                                request_monitoring:     false,
                                request:                request,
                                request_property_name:  property_name,
                                value:                  value
  end
end
