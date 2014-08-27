require 'rails_helper'

RSpec.describe Pesticide, :type => :model do
  let(:pesticide) { Pesticide.new(name: "THC") }
  describe 'basic model' do
    it { expect(pesticide).to validate_presence_of :name }
  end
  describe 'methods' do
    it { should respond_to :name }
    it { should respond_to :products }
  end
end
