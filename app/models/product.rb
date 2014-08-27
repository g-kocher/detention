class Product < ActiveRecord::Base
  attr_accessor :name, :date

  belongs_to :company
  has_many :problems
  has_many :pesticides, through: :problems

  validates :name, presence: true
  validates :date, presence: true
end
