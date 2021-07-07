# file: kickstarter_scraper.rb

require 'nokogiri'
require 'pry'
#
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end


  # return the projects hash
  projects
end



  can be called on with no errors
  returns a hash (FAILED - 1)
  includes at least five projects (FAILED - 2)
  project titles point to a hash of info (FAILED - 3)
  each project has an image link hosted on AmazonAWS (FAILED - 4)
  each project has a description which is a string (FAILED - 5)
  each project has a location which is a string (FAILED - 6)
  each project has percentage funded listed which is an integer (FAILED - 7)
