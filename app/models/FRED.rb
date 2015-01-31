class FRED
  def self.create_contact handle, partner: 'alpha'
    request = create_request request_type: contact_create_type, partner: partner

    create_property request: request, name: 'handle',   value: handle
    create_property request: request, name: 'rc',       value: 1000
    create_property request: request, name: 'msg',      value: 'Command completed successfully'

    ['pi.name', 'pi.street', 'pi.city', 'pi.postalCode', 'pi.countryCode', 'email'].each do |name|
      create_property request: request, name: name,  value: 'value'
    end

    request
  end

  def self.register_domain name, registrant, partner: 'alpha'
    request = create_request request_type: domain_create_type, partner: partner

    create_property request: request, name: 'handle',     value: name
    create_property request: request, name: 'registrant', value: registrant
    create_property request: request, name: 'period',     value: 1
    create_property request: request, name: 'timeunit',   value: 'Year'
    create_property request: request, name: 'nsset',      value: 'ABC123'
    create_property request: request, name: 'authInfo',   value: 'ABC123'

    create_property request: request, name: 'rc',         value: 1000
    create_property request: request, name: 'msg',        value: 'Command completed successfully'

    request
  end

  private

  def self.create_request partner:, request_type:
    Request.create  time_begin: Time.now,
                    time_end:   Time.now,
                    service_id: -1,
                    request_type: request_type,
                    user_name:  partner
  end

  def self.contact_create_type
    create_request_type RequestType::CONTACT_CREATE
  end

  def self.domain_create_type
    create_request_type RequestType::DOMAIN_CREATE
  end

  def self.create_request_type name
    unless RequestType.exists?(name: name)
      RequestType.create name: name, service_id: -1
    end

    RequestType.find_by(name: name)
  end

  def self.create_property name:, value:, request:
    unless RequestPropertyName.exists?(name: name)
      RequestPropertyName.create name: name
    end

    property_name = RequestPropertyName.find_by(name: name)

    RequestPropertyValue.create request_time_begin:     Time.now,
                                request_service_id:     -1,
                                request_monitoring:     false,
                                request:                request,
                                request_property_name:  property_name,
                                value:                  value
  end
end
