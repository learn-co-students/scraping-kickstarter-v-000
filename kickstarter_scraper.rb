# require libraries/modules here
require 'nokogiri'
require 'pry'

# write your code here
# projects: kickstarter.css("li.project.grid_4")
# title: projects.css(".bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css(".project-meta li").text

def create_project_hash
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css(".bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css(".project-meta li").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects
end
