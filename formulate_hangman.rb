require 'rest_client'
require 'nokogiri'
require 'open-uri'
require 'JSON'

class FormulateHangman

  def initialize
    @processed_countries = []
    @mineral_rock_words = []
    @dessert_words = []


  end

  #create hangman game variations for the following genres: countries, British desserts, rock and minerals


  def get_countries
    doc = Nokogiri::HTML(open('https://www.britannica.com/topic/list-of-countries-1993160'))
    countries_extracted = doc.css("li a").text.split('Britannica')[1].split(' geography')[0].rstrip
    @processed_countries = countries_extracted.split(/(?<!\s)(?=[A-Z])/)
  end


  def get_desserts
    dessert_block = Nokogiri::HTML(open('https://en.wikipedia.org/wiki/List_of_British_desserts'))
    desserts_extracted = dessert_block.css("li a").text
    pattern = /\[\d\]/
    d_words = desserts_extracted.split('References')[1].split('cranachan')[0].gsub(pattern,'')
    to_remove = [20,22,37,45,58,59,60,86,87,88,89,97,98]
    d_w = d_words.split(/(?<!\s)(?=[A-Z])/)
    @dessert_words =  d_w.select{|dessert| !to_remove.include?(d_w.index(dessert))}
  end

  def get_minerals
    html2 = open('http://www.gwydir.demon.co.uk/jo/minerals/alphabet.htm')
    rock_mineral_block = Nokogiri::HTML(html2)
    @mineral_rock_words = rock_mineral_block.css('a').text.split('by colour')[1].split(/(?<!\s)(?=[A-Z])/).uniq
  end

end
