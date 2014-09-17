class Company < ActiveRecord::Base
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true

end
