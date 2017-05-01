require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  #projects are contained in li.project.grid_4
  #iterate through the li.projects.drid_4 information
  # and separate by projects
  kickstarter.css("li.project.grid_4").each do |project|
    #title will be what is scrapped from 'h2.bbcard_name strong a' as that is the projects title in the css
    title = project.css("h2.bbcard_name strong a").text
    projects[title] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end
