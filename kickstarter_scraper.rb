# require libraries/modules here
# require 'open-uri' #not necessary because we are not using a real webpage
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
 #binding.pry
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
#binding.pry
  end

  # return the projects hash
  projects
  #binding.pry
end


### Below: code: leave 4 errors
# def create_project_hash
#   html = File.read('fixtures/kickstarter.html')
#   kickstarter = Nokogiri::HTML(html)
#  #binding.pry  # projects: kickstarter.css("li.project.grid_4")
#   projects = {}

#   # Iterate through the projects
#   kickstarter.css("li.project.grid_4").each do |project|
#     projects[project] = {}
#   end
#   # return the projects hash
#   projects
# end
#########
# projects: kickstarter.css("li.project.grid_4")
# title selector: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("span.location-name").text
# % funded: project.css("ul.project-stats li.first.funded strong").text
# % funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i  Convert to integer


#binding.pry