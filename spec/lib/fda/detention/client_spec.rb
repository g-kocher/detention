# coding: utf-8
require 'nokogiri'

module FDA
  module Detention
    class Client

      def initialize url
        @url = url
      end

      def parse html #returns an array of company hashes
        selector = "//span//div[@class='textbody_level1']//div[1]"
        page(html).xpath(selector).map do |item|
          company = {}
          company[:name] = item.text
          company[:address] = format_address(item.xpath("..").text)
          company
        end
      end

      def format_address raw
        raw.rstrip.split("\n").drop(3).map{|s| s.gsub(",", "").strip}.join(", ")
      end

      def companies html
        selector = "//span//div[@class='textbody_level1']//div[1]"
        list = countries html
        page(html).xpath(selector).map do |company|
          company.text unless list.include?(company.text)
        end
      end

      def countries html
        selector = "//span//div[@class='textbody_level1'][@align='center']"
        page(html).xpath(selector).map do |country|
          country.text
        end
      end

      def page html
        page = Nokogiri::HTML html
      end


    end
  end
end


module FDA
  module Detention
    describe Client do
      
      let(:detention_link) { 'http://www.accessdata.fda.gov/cms_ia/importalert_259.html' }
      let(:html) { File.read(File.join('spec', 'fixtures', 'import.html')) }
      let(:detentions) { Client.new(detention_link).parse html }

      context 'internal features' do
 
        it 'generates a list of countries' do
          countries = Client.new(detention_link).countries html
          expect(countries.first).to eq 'AFGHANISTAN'
        end

        it 'generates a list of companies' do
          companies = Client.new(detention_link).companies html
          expect(companies.first).to eq 'Haji Bashir Ahmad Commercial Firm'
        end

      end


      context 'parses HTML' do

        it 'extracts the first company' do
          detention = detentions.first
          expect(detention[:name]).to eq 'Haji Bashir Ahmad Commercial Firm'
        end

        it 'extracts the last company' do
          detention = detentions.last
          expect(detention[:name]).to eq 'Tamiska d.o.o.'
        end

        it 'extracts the first company address' do
          detention = detentions.first
          expect(detention[:address]).to eq 'Charagh Ali Market, kabul, AF-KAB AFGHANISTAN'
        end

        it 'extracts the last company address' do
          detention = detentions.last
          expect(detention[:address]).to eq 'Skadarska bb, Pancevo, YU-NOTA YUGOSLAVIA'
        end


      end
    end
  end
end