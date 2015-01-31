FactoryGirl.define do
  factory :request_type do
    name  'UnknownAction'
    service_id  -1

    factory :contact_create_type do
      name 'ContactCreate'
    end
  end
end
