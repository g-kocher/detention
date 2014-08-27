require 'rails_helper'

RSpec.describe Problem, :type => :model do
  let(:problem) { Problem.new }
  describe 'basic model' do
    it { expect(problem).to validate_presence_of :product_id }
    it { expect(problem).to validate_presence_of :pesticide_id }
  end
end
