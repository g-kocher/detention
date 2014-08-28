require 'rails_helper'

RSpec.describe Import, :type => :model do
  let(:import) { Import.new() }
  describe "basic model" do
    it { expect(import).to validate_presence_of :last_update}
  end

end
