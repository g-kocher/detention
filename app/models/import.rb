class Import < ActiveRecord::Base
  validates :last_update, presence: true
end
