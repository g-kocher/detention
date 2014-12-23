require 'faker'

FactoryGirl.define do
  factory :company do |f|
    f.name {Faker::Company.name}
    f.address { Faker::Address.street_address + ", " + Faker::Address.city + " " + Faker::Address.country }
  end

  factory :product do |f|
    f.name {Faker::Commerce.product_name}
    f.date_published {Date.today}
    f.company {FactoryGirl.create(:company)}
  end
end