# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  projects = Hash.new

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("ul.project-meta span.location-name").text,
      percent_funded: project.css("ul.project-stats li strong").text.gsub("%", "").to_i
    }
  end

  projects
end

#projects: kickstarter.css("li.project.grid_4")
#title: kickstarter.css("h2.bbcard_name strong a").text
#image: kickstarter.css("div.project-thumbnail a img").attribute("src").value
#desc: kickstarter.css("p.bbcard_blurb").text
#location: kickstarter.css("ul.project-meta span.location-name").text
#percent: kickstarter.css("ul.project-stats li strong").text.gsub("%", "").to_i
