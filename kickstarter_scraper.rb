require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css(".project-card").each do |project|
    project_name = project.css("h2.bbcard_name a").text
    projects[project_name.to_sym] = {
      :image_link => project.css("img.projectphoto-little").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text.gsub("\n",""),
      :location => project.css("span.location-name").text,
      :percent_funded => project.css("li.first.funded").text.gsub("%","").to_i
    }
  end
  projects
end

create_project_hash
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name a").text
# image link: project.css("img.projectphoto-little").attribute("src").value
# description: project.css("p.bbcard_blurb").text.gsub("\n","")
# location: project.css("span.location-name").text
# percent_funded: project.css("li.first.funded").text.gsub("%","").to_i
