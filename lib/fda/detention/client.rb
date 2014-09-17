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
      def get url
        open url
      end

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
              pesticides = text.gsub(/[\n\r\t]/,'').split(";").drop(1).map {|i| i.downcase.strip}
              companies[i][:products][j][:pesticides] = pesticides
            end
            if text =~ /[0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{2}/
              companies[i][:products][j][:date] = format_date text
            end
            companies[i][:products][j]
          when "textbody_level4"
            pesticides = format_pesticides attribute.xpath("./small").text
            companies[i][:products][j][:pesticides] = pesticides
          end
        end
        companies
      end

      def format_address raw
        raw.encode!('UTF-8', :invalid => :replace, :undef => :replace)
        raw.rstrip.split("\n").drop(3).map do |s|
          s.gsub(",", "").strip
        end.join(", ")
      end

      def format_date raw
        if raw =~ /[0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{4}/
          date = /([0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{4})/.match(raw).captures.first
          Date.strptime(date, "%m/%d/%Y")
        elsif raw =~ /[0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{2}/
          date = /([0-1]?[0-9]\/[0-3]?[0-9]\/[0-9]{2})/.match(raw).captures.first
          Date.strptime(date, "%m/%d/%y")
        end
      end
      def format_pesticides raw
        raw.sub("Problems:", "").split(";").map do |i| 
          i.upcase.gsub(/\A\p{Space}*/,'')
        end
      end

    end
  end
end