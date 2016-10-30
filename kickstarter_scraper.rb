require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('./fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css(".project-card").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    # we convert the title into a symbol
    projects[title.to_sym] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i 
    }
  end

  projects
end

# projects: kickstarter.css(".project-card")
# iterate over each project
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("span.location-name").text
# funding: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
