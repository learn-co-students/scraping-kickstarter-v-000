require 'nokogiri'
require 'pry'

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  projects = {}
    kickstarter.css("div.project-card").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("span.location-name").text,
        :percent_funded => project.css("li.first.funded strong").text.gsub("%","").to_i
      }
    end
  projects
end

#project: project = kickstarter.css("div.project-card")[0]
#title: project.css("h2.bbcard_name strong a").text
#thumbnail: project.css("div.project-thumbnail a img").attribute("src").value
#discription: project.css("p.bbcard_blurb").text
#percentage: project.css("li.first.funded strong").text.gsub("%","").to_i
