require 'nokogiri'
require 'pry'# require libraries/modules here

def create_project_hash
  
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  #kickstarter.css(".project grid_4").first gets first project
  #project.css("h2.bbcard_name strong a").text  gets project name
  #project.css("div.project-thumbnail a img").attribute("src").value gets image link
  #project.css("p.bbcard_blurb").text   project blurb
  #project.css("project.css("ul.project-meta a").text.gsub("\n","") gets Location
  #project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i gets percent funded


  projects = {}
  #Iterates through project list and creates a hash for each project where they can store their information.

  kickstarter.css(".project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta a").text.gsub("\n",""),
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects
end





  
