# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    #binding.pry
    projects[title.to_sym] = {
      :image_link => kickstarter.css("div.project-thumbnail a img").attribute("src").value,
      :description => kickstarter.css("p.bbcard_blurb").text.strip,
      :location => kickstarter.css(".project-meta li a span.location-name").text,
      :percent_funded => kickstarter.css(".funded strong").text.gsub("%","").to_i
    }
  end

  projects
end

create_project_hash
