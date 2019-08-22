# require libraries/modules here

require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  # This just opens a file and reads it into a variable
  # We iterate through the kickstarter nokogiri html to grab the project title of each project.
  # The method converts the title to a symbol (symbols are better keys for a hash).
  # The key's value, the hash, gets all the other values we found about the projects.
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
