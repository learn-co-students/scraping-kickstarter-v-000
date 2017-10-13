# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each {
    |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  }
  projects
end

create_project_hash

# projects => kickstarter.css("li.project.grid_4").first
# titles of projects => project.css("h2.bbcard_name strong a").text
# image => project.css("div.project-thumbnail a img").attribute("src").value
# description => project.css("p.bbcard_blurb").text
# location => project.css("ul.project-meta").text
# %funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
