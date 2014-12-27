require 'faker'

FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Commerce.product_name }
    f.date_published { Date.today }
    f.company { FactoryGirl.create(:company) }
  end
end