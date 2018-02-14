require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  #Iterate through the projects and return their titles
  #projects: kickstarter.css("li.project.grid_4")
  #title: project.css("h2.bbcard_name strong a").text
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      #retrieve the rest of the attributes and put them in a hash
      #image link: project.css("div.project-thumbnail a img").attribute("src").value
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      #description: project.css("p.bbcard_blurb").text
      :description => project.css("p.bbcard_blurb").text,
      #location: project.css("div.project-meta span.location-name").text
      :location => project.css("ul.project-meta span.location-name").text,
      #percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end

create_project_hash
