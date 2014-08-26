# coding: utf-8
require 'spec_helper'
require 'nokogiri'
require 'date'
require 'open-uri'

module FDA
  module Detention
    class Client
      attr_reader :url

      def initialize url
        @url = url
      end

      def fetch
        html = get @url
        parse html
      end 

      def parse html
        build_companies_from extracted_attributes(html)
      end

      private
      def extracted_attributes html
        doc = Nokogiri::HTML html
        classes = "@class='textbody_level1' or @class='textbody_level2' or @class='textbody_level3' or @class='textbody_level4'"
        path = "//span[@id='user_provided']/div[#{classes}]"
        doc.xpath(path).map do |attribute|
          attribute unless attribute.xpath("attribute::align").text == 'center'
        end.compact
      end

      def build_companies_from attributes
        companies = []
        i = -1
        j = 0
        attributes.each do |attribute|
          case attribute.xpath("attribute::class").text 
          when "textbody_level1"
            i += 1
            j = -1
            company = {}
            company[:name] = attribute.xpath("./div[1]").text
            company[:address] = format_address attribute.text
            companies[i] = company
          when "textbody_level2"
            j += 1
            company = companies[i]
            company[:products] ||= []
            company[:products][j] ||= {}
            company[:products][j][:name] = attribute.xpath('./div[1]').text.strip
            company[:products][j][:date] = format_date attribute.xpath('./div[2]').text
            companies[i] = company
          when "textbody_level3"
            text = attribute.text
            if text =~ /Notes:Problem/
              problems = text.split(";").drop(1).each {|i| i.strip!}
              companies[i][:products][j][:problems] = problems
            end
            if text =~ /[0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{2}/
              companies[i][:products][j][:date] = format_date text
            end
            companies[i][:products][j]
          when "textbody_level4"
            problems = format_problems attribute.xpath("./small").text
            companies[i][:products][j][:problems] = problems
          end
        end
        companies
      end

      def format_address raw
        raw.rstrip.split("\n").drop(3).map do |s|
          s.gsub(",", "").strip
        end.join(", ")
      end

      def format_date raw
        if raw =~ /[0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{4}\s/
          date = /([0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{4}\s)/.match(raw).captures.first
          Date.strptime(date, "%m/%d/%Y")
        elsif raw =~ /[0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{2}\s/
          date = /([0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{2}\s)/.match(raw).captures.first
          Date.strptime(date, "%m/%d/%y")
        end
      end
      def format_problems raw
        raw.sub("Problems:", "").gsub("\n", "").strip.split(";").each {|i| i.strip!}
      end

    end
  end
end


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