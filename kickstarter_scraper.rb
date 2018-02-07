require 'pry'
require 'nokogiri'

# projects: kickstarter.css("li.project.grid_4")
# titles: project.css("h2.bbcard_name strong a").text
# image links: project.css("div.project-thumbnail a img").attribute("src").value
# descriptions: project.css("p.bbcard_blurb").text
# locations: project.css("span.location-name").text
# funded status: project.css("li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  
  projects = {}
  
  kickstarter = Nokogiri::HTML(html)
  
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  
  projects
end

create_project_hash