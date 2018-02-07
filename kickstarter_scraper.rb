# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  project = kickstarter.css("li.project.grid_4")

  projects = {}
  project.each do |project|
    title = project.css("h2.bbcard_name strong a").text
    image_link = project.css("img.projectphoto-little").attribute("src").value
    description = project.css(".project-card p.bbcard_blurb").text
    location = project.css(".project-card ul.project-meta a span.location-name").text
    percent_funded = project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

    projects[title.to_sym] = {image_link: image_link, description: description,
    location: location, percent_funded: percent_funded}
  end
  projects
end

create_project_hash
