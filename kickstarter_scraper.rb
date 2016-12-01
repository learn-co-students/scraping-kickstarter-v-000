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
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

 # Iterate through the projects

  # Ok, so that won't work, actually. That's going to make some really wacky key which is a huge Nokogiri object.
  # So, let's change our data structure slightly and make it so that each project title is a key, and the value is
  # another hash with each of our other data points as keys. Sound good?

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
