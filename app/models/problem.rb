class Problem < ActiveRecord::Base
  belongs_to :product
  belongs_to :pesticide
  
  validates :product_id, :pesticide_id, presence: true
end
