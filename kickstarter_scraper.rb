# require libraries/modules here
require 'pry'
require 'nokogiri'
def create_project_hash
  # write your code here
  # This just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
#img: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
projects = {}

# Iterate through the projects

 kickstarter.css("li.project.grid_4").each do |project|
   title = project.css("h2.bbcard_name strong a").text
   projects[title.to_sym] = {
     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
     :description => project.css("p.bbcard_blurb").text,
     :location => project.css("ul.project-meta span.location-name").text,
     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
   }
 end


projects

end
