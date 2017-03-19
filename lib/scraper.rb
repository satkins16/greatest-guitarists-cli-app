require_relative '../config/environment'
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.create_ranker
    website = Nokogiri::HTML(open("http://www.imdb.com/list/ls052192776/"))
    #website.css(".list_item .info b a").text
    @guitarists_name_array = []
    website.css(".list_item .info b a").each do |block|
      @guitarists_name_array << block.text
    end
    @guitarists_ranker = []
    counter = 1
    @guitarists_name_array.collect do |guitarist|
      @guitarists_ranker << "#{counter}. #{guitarist}"
      counter += 1
    end
    @guitarists_ranker
  end

  def self.print_ranker
    puts ""
    puts Scraper.create_ranker
  end

  def self.create_info
    website = Nokogiri::HTML(open("http://www.rollingstone.com/music/lists/100-greatest-guitarists-20111123"))
    @info = website.css(".collection-item p").text
    @info
  end

  def self.print_info
    puts ""
    puts Scraper.create_info.gsub("e.THE VOTERS", "e.\n\nTHE VOTERS")
  end

  Scraper.create_ranker
end
