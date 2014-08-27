class Company < ActiveRecord::Base
  has_many :products

  validates :name, presence: true
  validates :address, presence: true
  validates :products, presence: true

end
