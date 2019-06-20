# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css(".project-card").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project.css(".project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("ul.project-meta li a span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i,
    }
  end
  # binding.pry

  projects
end

create_project_hash


# Flatiron says: projects: kickstarter.css("li.project.grid_4")
# # I think:
# projects: kickstarter.css(".project-card")
# title: project.css("h2.bbcard_name strong a").text
# imagelink: project.css(".project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta li a span.location-name").text
# percentagefunded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
