require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'basic model' do
    let(:user) {User.new(user_id: 'gkocher', name: 'garrett', email: 'user@address.com', active: true)}
    it { expect(user).to validate_presence_of :user_id }
    it { expect(user).to validate_presence_of :name }
    it { expect(user).to validate_presence_of :email }

  end
end
