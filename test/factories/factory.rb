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
end
