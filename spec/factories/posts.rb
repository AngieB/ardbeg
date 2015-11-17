FactoryGirl.define do
  factory :post do
    title Faker::Book.title
    name Faker::Name.name
    body Faker::Lorem.paragraph(2)
  end
end
