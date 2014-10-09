class Pesticide < ActiveRecord::Base

  has_many :problems
  has_many :products, through: :problems

  validates :name, presence: true

  scope :every_single_one, -> {all}
end
