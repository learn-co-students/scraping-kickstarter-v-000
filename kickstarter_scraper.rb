# require libraries/modules here
require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image_link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta li a span.location-name").text
# funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

   kickstarter.css("li.project.grid_4").each {|p|
     projects[p.css("h2.bbcard_name strong a").text.to_sym] = {
         :image_link => p.css("div.project-thumbnail a img").attribute("src").value,
         :description => p.css("p.bbcard_blurb").text,
         :location => p.css("ul.project-meta span.location-name").text,
         :percent_funded => p.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
       }
   }


  projects
end
