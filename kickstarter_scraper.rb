require 'nokogiri'
require 'pry'
# require libraries/modules here

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image_link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text   
# location: project.css("span.location-name").text
# funded: project.css("li.first.funded strong").text.gsub("%", "").to_i  
  #.gsub deletes the percent sign and turns to integer

  def create_project_hash
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)
    
    projects = {}

    kickstarter.css("li.project.grid_4").each do |project|
       title = project.css("h2.bbcard_name strong a").text
        projects[title.to_sym] = {
          :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
          :description => project.css("p.bbcard_blurb").text,
          :location => project.css("span.location-name").text,
          :percent_funded => project.css("li.first.funded strong").text.gsub("%", "").to_i
        }
    end
    projects
  end  
