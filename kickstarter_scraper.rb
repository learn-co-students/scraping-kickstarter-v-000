# require libraries/modules here
require 'nokogiri'
require 'pry'
# Each project has a title, an image, a short description, a location and some funding details.

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html) #this loads the html data from the 'html' file into a variable. We see that this Nokogiri object is a bunch of nested nodes.
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end
  
  projects

end

#projects: kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta li a span.location-name").text
#percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
# **** The above gsub function takes the percentage (77%) and removes the %, and converts 77 into an integer 77 which can then be used later on. ***
