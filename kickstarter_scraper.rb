# require libraries/modules here
require "Nokogiri"
require "pry"
def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project.grid_4").each {|project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym]={
      :image_link => project.css("div.project-thumbnail a img.projectphoto-little").attribute('src').value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }

  }
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # source: project.css("div.project-thumbnail a img.projectphoto-little").attribute('src').value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("li a span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

  projects
  
end

create_project_hash
