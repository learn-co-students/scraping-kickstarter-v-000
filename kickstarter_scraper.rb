# require libraries/modules here
require 'nokogiri'
require 'pry'
#Nokogiri goes through an html tag and navigates it like a tree.
#It uses CSS collector to interact through it.
#The project at the end uses scraping and is about scraping.
#You get data by parsing html using Nokogiri
#Basically Nokogiri takes the data from a website and makes it easier to use
# a giant getter for websites to ruby
# think container wise about where you want your data from.
#review css and play around with the Nokogiri



  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text

  #put kickstarter.css("li.project.grid_4").first in pry and tried it.
  #did project = _ to assign project to a variable.

  #The variable_name = _ syntax used in Pry will assign the variable name to the return value of whatever was executed above. For example:

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
