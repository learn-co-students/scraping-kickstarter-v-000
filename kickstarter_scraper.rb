require 'nokogiri'
require 'pry'
def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)


  listings = kickstarter.css(".project-card")
  #binding.pry

  collection = {}
  listings.each do |listing|
    project = {
      :image_link => listing.css("img").attribute("src").value,
      :description => listing.css(".bbcard_blurb").text,
      :location => listing.css(".location-name").text,
      :percent_funded =>  listing.css(".funded").css("strong").text.chop.to_i
    }
    collection[(listing.css(".bbcard_name").css("a").text).to_sym] = project
  end
  #binding.pry
  collection
end












=begin
class Project
  attr_accessor :image_link, :description, :location, :percent_funded
  @all = []

  def initialize
    @all << self
  end

create_project_hash


end
=end
