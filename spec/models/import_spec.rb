# need to create a fixture for the refresh data



require 'rails_helper'

RSpec.describe Import, :type => :model do
  let(:import) { Import.new }
  let(:data) { YAML.load_file("#{Rails.root}/spec/fixtures/import_initial.yml") }
  describe "basic model" do
    it { expect(import).to validate_presence_of :items_created}
  end

  describe "#refresh" do

    context "empty database" do


      it 'saves companies' do
        expect{ import.refresh(data[:initial]) }.to change{ Company.count }.from(0).to(3)
      end
      it 'saves products' do
        expect{ import.refresh(data[:initial]) }.to change{ Product.count }.from(0).to(5)
      end
      it 'saves pesticides' do
        expect { import.refresh(data[:initial]) }.to change{ Pesticide.count }.from(0).to(4)
        expect(Pesticide.first.name).to eq 'FLUSILAZOLE'
      end
    end


    context 'database with data' do
      before(:each) do
        import.refresh data[:initial]
      end

      it 'adds new companies' do
        expect{ import.refresh(data[:update]) }.to change{ Company.count }.from(3).to(4)
        expect(Company.last.name).to eq 'Starbucks'
      end
      it 'adds new products' do
        expect{ import.refresh(data[:update]) }.to change{ Product.count }.from(5).to(7)
      end
      it 'adds new pesticides' do
        expect { import.refresh(data[:update])}.to change{ Pesticide.count}.from(4).to(5)
      end
    end
  end
end
