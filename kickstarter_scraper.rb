# require libraries/modules here
require 'nokogiri'
require 'pry'

#kickstarter.css("div.project-card")
#project name: kickstarter.css("div.project-card h2.bbcard_name strong a").text
#project image: kickstarter.css("div.project-card div.project-thumbnail a img").attribute("src").value
#project description: kickstarter.css("div.project-card p.bbcard_blurb").text
#project location: kickstarter.css("div.project-card ul.project-meta li a span.location-name").text
#project funded: kickstarter.css("div.project-card ul.project-stats li.first.funded strong").text.gsub("%","").to_i
def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects ={}

  kickstarter.css("div.project-card").each do |project|
    title = project.css("h2.bbcard_name strong a").text.to_sym
    projects[title] = {}
    projects[title][:image_link] = project.css("div.project-thumbnail a img").attribute("src").value
    projects[title][:description] = project.css("p.bbcard_blurb").text
    projects[title][:location] = project.css("ul.project-meta li a span.location-name").text
    projects[title][:percent_funded] = project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  end
  projects
end