# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project.grid_4").each do |p|
    title = p.css("h2.bbcard_name strong a").text.to_sym
    projects[title] = {} 
    projects[title][:image_link] = p.css("div.project-thumbnail a img").attribute("src").value 
    projects[title][:description] = p.css("p.bbcard_blurb").text
    projects[title][:location] = p.css("ul.project-meta li span.location-name").text 
    projects[title][:percent_funded] = p.css("ul.project_stats li.first.funded strong").text.gsub("%", "").to_i 
  end 
  projects  
end

#projects = {} 



# projects: kickstarter.css("li.project.grid_4").text 
# projects each do |p|
    #title = p.css("h2.bbcard_name strong a")
    #image_link = p.css("div.project-thumbnail a img").attribute("src").value  
    #description = p.css("p.bbcard_blurb").text 
    #location = p.css("ul.project-meta li a span.location-name").text 
    #percent funded = p.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
#create_project_hash