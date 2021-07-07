require 'nokogiri'
require 'pry'

# These are the scrapes needed to get us what we're looking for:

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  # This code below created a massive hash of all sorts of key/value pairs:

  # kickstarter.css("li.project.grid_4").each do |project|
  #   projects[project] = {}

  # This code below created the right set up but the rest of the project's values are not inside the title hash:

  # kickstarter.css("li.project.grid_4").each do |project|
  # title = project.css("h2.bbcard_name strong a").text
  #   projects[title.to_sym] = {}

  # This is the correct setup below:

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
        image_link: project.css("div.project-thumbnail a img").attribute("src").value,
        description: project.css("p.bbcard_blurb").text,
        location: project.css("ul.project-meta span.location-name").text,
        percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end



p create_project_hash
