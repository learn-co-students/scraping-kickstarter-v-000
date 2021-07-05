# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
html = File.read('fixtures/kickstarter.html')

kickstarter = Nokogiri::HTML(html)
project = kickstarter.css("li.project.grid_4")
#title: project.css("h2 a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
#location: project.css("span.location-name").text
#percent_funded: project.css("li.first.funded strong").text.gsub("%", "").to_i

projects = {}

project.each do |project|
title = project.css("h2 a").text
projects[title.to_sym] = {

image_link: project.css("div.project-thumbnail a img").attribute("src").value,
description: project.css("p.bbcard_blurb").text,
location: project.css("span.location-name").text,
percent_funded: project.css("li.first.funded strong").text.gsub("%", "").to_i
}
end
return projects
end
