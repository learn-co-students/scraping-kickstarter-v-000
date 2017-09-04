require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end # End of create_project_hash


# projects: kickstarter.css("li.project.grid_4")
# title selector project.css("h2.bbcard_name strong a").text
# image selector project.css("div.project-thumbnail a img").attribute("src").value
# description selector project.css("p.bbcard_blurb").text
#  location selector project.css("ul.project-meta li a span.location-name").text
#project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

# create_project_hash
