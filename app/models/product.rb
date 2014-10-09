class Product < ActiveRecord::Base
  belongs_to :company, counter_cache: true
  has_many :problems
  has_many :pesticides, through: :problems

  validates :name, presence: true
  validates :date_published, presence: true
  validates :company_id, presence: true

  scope :recent, ->(number) { order(date_published: :desc).limit(number)}
  scope :every_single_one, -> {all}  
end
