require 'pry'
require 'nokogiri'

def create_project_hash
  html = File.read("fixtures/kickstarter.html")

  kickstarter = Nokogiri::HTML(html)
  binding.pry
end

create_project_hash

# Project: kickstarter.css("li.project.grid_4")
# Title: project.css("h2.bbcard_name strong a").text
# Image: project.css("div.project-thumbnail a img").attribute("src").value
# Description: project.css("p.bbcard_blurb").text
# Location: project.css("span.location-name").text
# Percent funded: project.css("ul.project-stats li.first.funded strong").text
