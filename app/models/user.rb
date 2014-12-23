class User < ActiveRecord::Base

  validates :user_id, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :active, inclusion: { in: [true, false]}

  scope :active, -> { where(active: true)}

end
