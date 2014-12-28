require 'faker'

FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Commerce.product_name }
    f.date_published { Faker::Date.between(2.years.ago, Date.yesterday) }
    f.company { FactoryGirl.create(:company) }
  end
end