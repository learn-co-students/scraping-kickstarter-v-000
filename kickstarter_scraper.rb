# require libraries/modules here
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("span.location-name").text
# percent_funded: project.css("li.first.funded strong").text.gsub("%","").to_i

#The variable_name = _ syntax used in Pry will assign the variable name to the return value of whatever was executed above.


require 'nokogiri'
require 'pry'

#class Kickstarter

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}
  # Iterate through the projects so that each project title is a key,
  # and the value is another hash with each of our other data points as keys.
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    #converting the title into a symbol using the to_sym method.
    #symbols make better hash keys than strings.
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
       :description => project.css("p.bbcard_blurb").text,
       :location => project.css("ul.project-meta span.location-name").text,
       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
end
#return the projects hash
projects
end
#end
#project.css("p.bbcard_blurb").text
#Kickstarter.new.create_project_hash
