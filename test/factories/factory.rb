FactoryGirl.define do
  factory :request do
    time_begin  Time.now
    time_end    Time.now
    service_id  -1
    request_type
  end

  factory :request_type do
    name  'UnknownAction'
    service_id  -1
  end

  factory :request_property_value do
    request_time_begin  Time.now
    request_service_id  -1
    request_monitoring  false
    request
    property_name_id    -1
    value               'value'
  end
end
