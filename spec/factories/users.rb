require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Commerce.product_name }
    f.user_id { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.active { true }
  end
end