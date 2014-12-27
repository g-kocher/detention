require 'faker'

FactoryGirl.define do
  factory :company do |f|
    f.name { Faker::Company.name }
    f.address { Faker::Address.street_address + ", " + Faker::Address.city + " " + Faker::Address.country }
  end
end