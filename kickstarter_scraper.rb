require "nokogiri"
require "pry"
#projects: kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
#img link: project.css("div.project-thubmnail a img").attribute('src').value
#description project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta span.location-name").text
#percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  #iterates through project hash
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute('src').value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  #return projects
  projects
end

create_project_hash
