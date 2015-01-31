FactoryGirl.define do
  factory :request do
    time_begin  Time.now
    time_end    Time.now
    service_id  -1
    request_type
    user_name   'alpha'

    factory :contact_create_request do
      association :request_type, factory: :contact_create_type
    end
  end
end
