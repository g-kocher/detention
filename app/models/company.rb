class Company < ActiveRecord::Base
  has_many :products
  has_many :pesticides, through: :products

  validates :name, presence: true
  validates :address, presence: true

  scope :every_single_one, -> {all}
end