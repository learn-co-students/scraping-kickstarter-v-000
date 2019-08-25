require 'nokogiri'
require 'pry'

def create_project_hash
  
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    image_link = project.css("img.projectphoto-little").attribute("src").value
    description = project.css("p.bbcard_blurb").text
    location = project.css("ul.project-meta span.location-name").text
    percent_funded = project.css("ul.project-stats strong").text.chomp("%").to_i
    projects[title] = {:image_link => image_link, :description => description, :location => location, :percent_funded => percent_funded}
  end

  projects
  #binding.pry

end

#create_project_hash

