require 'benchmark'
require 'nokogiri'

puts Dir.getwd

doc = Nokogiri::HTML File.read(File.join('spec', 'fixtures', 'import.html'))


Benchmark.bm(15) do |x|
  x.report('xpath:') {(1..100).each {doc.xpath("//span//div[@class='textbody_level1'][@align='center']").text}}
  x.report('xpath with font:') {(1..100).each {doc.xpath("//span//div[@class='textbody_level1'][@align='center']/font").text}}
end