# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css("li.project.grid_4");

  project_hash = {}
  projects.each do |project|
    title= project.css("h2.bbcard_name strong a").text
    project_hash[title]={
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("ul.project-meta span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  project_hash
end
