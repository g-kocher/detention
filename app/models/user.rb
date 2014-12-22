class User < ActiveRecord::Base
  before_save :default_values

  validates :user_id, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :active, presence: true

  def default_values
    self.active ||= true
  end
end
