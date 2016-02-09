# require libraries/modules here
require 'pry'
require 'Nokogiri'

def create_project_hash
  # This just opens a file and reads it into a variable
  project_hash = {}
  html = File.read('fixtures/kickstarter.html')
   
  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css("li.project.grid_4")
  projects.each {|project| 
    title = project.css("h2.bbcard_name strong").text
    img = project.css("div.project-thumbnail a img").attribute("src").value
    description = project.css("p.bbcard_blurb").text
    location = project.css("ul.project-meta span.location-name").text
    percentfunded = project.css("ul.project-stats li.first.funded strong").text
    project_hash[title] = {}
    project_hash[title][:image_link] = img
    project_hash[title][:description] = description
    project_hash[title][:location] = location
    percentfunded = percentfunded.split("%")[0].to_i
    project_hash[title][:percent_funded] = percentfunded
  }
  project_hash
  # write your code here
end