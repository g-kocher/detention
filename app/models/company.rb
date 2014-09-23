class Company < ActiveRecord::Base
  has_many :products
  has_many :pesticides, through: :products

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true

end