FactoryGirl.define do
  factory :request_property_value do
    request_time_begin  Time.now
    request_service_id  -1
    request_monitoring  false
    request
    request_property_name
    value               'value'
  end
end
