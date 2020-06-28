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
    :description => project.css("p.bbcard_blurb").text.strip,
    :location => project.css("li a span.location-name").text,
    :percent_funded => project.css("li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects
end

create_project_hash
# projects: kickstarter.css("li.project.grid_4")
#title: kickstarter.css("h2.bbcard_name strong a")
#image Link: kickstarter.css("div.project-thumbnail a img").attribute("src").value
#description: kickstarter.css("p.bbcard_blurb")
#location: kickstarter.css("li a span.location-name")
#% Funded: kickstarter.css("li.first.funded strong").gsub("%","").to_i
