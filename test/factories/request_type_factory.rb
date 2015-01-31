FactoryGirl.define do
  factory :request_type do
    name  'UnknownAction'
    service_id  -1

    factory :contact_create_type do
      name RequestType::CONTACT_CREATE
    end

    factory :domain_create_type do
      name RequestType::DOMAIN_CREATE
    end
  end
end
