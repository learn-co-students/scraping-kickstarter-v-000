# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects =  {}

  kickstarter.css("li.project.grid_4").each do |text|
    title = text.css("h2.bbcard_name strong a").text
    image_link = text.css("div.project-thumbnail a img").attribute("src").value
    description =  text.css("p.bbcard_blurb").text
    location = text.css("ul.project-meta span.location-name").text
    percent_funded = text.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


    projects[title.to_sym] = {image_link: image_link, description: description, location: location, percent_funded: percent_funded }

  end

  projects
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

end

create_project_hash
