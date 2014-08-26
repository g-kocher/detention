# coding: utf-8
require 'spec_helper'
require_relative '../../../../lib/fda/detention/client'


module FDA
  module Detention
    describe Client do

      
      let(:client) { Client.new 'example.com/fda/import' }
      let(:html)       { Factory.detention_data }
      
      describe '#initialize' do 
        it 'stores the link' do
          expect(client.url).to eq 'example.com/fda/import'
        end
      end

      describe '#fetch' do
        let(:companies) { client.fetch }
        before(:each) do
          expect(client).to receive(:get).and_return(html)
        end

        it 'has companies' do
          expect(companies.size).to eq 85
        end
      end

      describe '#parse' do
        let(:detentions) { client.parse html}
        let(:detention)  { detentions.first }
        let(:product)    { detention[:products].first }

        context 'For normal enteries' do
          let(:detention)  { detentions.first }
          let(:product)    { detention[:products].first }
          let(:problem)    { product[:problems].first }
          it 'extracts the company name' do
            expect(detention[:name]).to eq "Haji Bashir Ahmad Commercial Firm"
          end

          it 'extracts the company address' do
            expect(detention[:address]).to eq "Charagh Ali Market, kabul, AF-KAB AFGHANISTAN"
          end

          it 'extracts the products' do
            expect(detention[:products].class).to eq Array.new.class
            expect(product[:name]).to eq '20 B - - 10  Raisins,  Dried or Paste'
          end

          it 'extracts the product date' do
            expect(product[:date]).to eq Date.new(2013, 4, 20)
          end

          it 'extracts the problems' do
            expect(product[:problems].class).to eq Array.new.class
            expect(problem).to eq 'FLUSILAZOLE'
          end
        end

        context 'old enteries' do
          let(:detention)  { detentions[2] }
          let(:product)    { detention[:products].first }
          it 'extracts the correct date' do
            expect(product[:date]).to eq Date.new(1998, 3, 16)
          end
        end

        context 'incorrectly input problems' do
          let(:detention)  { detentions[-1] }
          let(:product)    { detention[:products].first }
          let(:problem)    { product[:problems].first }
          it 'extracts the problem from the notes' do
            expect(product[:problems].class).to eq Array.new.class
            expect(problem).to eq 'Fenobucarb'
          end
        end
      end
    end
  end
end