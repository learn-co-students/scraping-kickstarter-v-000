# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
 
  kickstarter = Nokogiri::HTML(html)
  
  projects = {}
  
  # Iterate through projects
  
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded =>  project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  
  projects
  
  # title: project.css("h2.bbcard_name strong a").text  
  # (returns a list of titles)
  
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # (returns a single link)
  
  # description: project.css("p.bbcard_blurb").text
  # (returns a list of descriptions)
  
  # location: project.css("ul.project-meta li a span.location-name").text

  # location: project.css("ul.project-meta span.location-name").text
  # (returns list of locations)
  
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

  #binding.pry
end

create_project_hash