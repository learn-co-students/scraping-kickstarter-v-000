require 'nokogiri'
require 'pry'
def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  listings = kickstarter.css("li.project.grid_4")
  #listings = kickstarter.css(".project-card")
  #binding.pry

  collection = {}
  listings.each do |listing|
    project = {
      :image_link => listing.css("div.project-thumbnail a img").attribute("src").value,
      :description => listing.css("p.bbcard_blurb").text,
      :location => listing.css("ul.project-meta span.location-name").text,
      :percent_funded =>  listing.css("ul.project-stats li.first.funded strong").css("strong").text.chop.to_i
    }
    collection[(listing.css("h2.bbcard_name strong a").text).to_sym] = project
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
