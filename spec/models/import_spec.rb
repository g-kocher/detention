# need to create a fixture for the refresh data



require 'rails_helper'

RSpec.describe Import, :type => :model do
  let(:import) { Import.new }
  describe "basic model" do
    it { expect(import).to validate_presence_of :items_created}
  end

  describe "#refresh" do

    context "empty database" do
      let(:data) { YAML.load_file("#{Rails.root}/spec/fixtures/import_initial.yml") }
      before(:each) do
        expect_any_instance_of(FDA::Detention::Client).to receive(:fetch).and_return(data[:initial])
      end

      it 'saves companies' do
        expect{ import.refresh }.to change{ Company.count }.from(0).to(3)
      end
      it 'saves products' do
        expect{ import.refresh }.to change{ Product.count }.from(0).to(5)
      end
      it 'saves pesticides' do
        expect { import.refresh }.to change{ Pesticide.count }.from(0).to(4)
        expect(Pesticide.first.name).to eq 'FLUSILAZOLE'
      end
    end


    context 'database with data' do


    end

  end

end
