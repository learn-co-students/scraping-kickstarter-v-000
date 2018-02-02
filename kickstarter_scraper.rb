require 'nokogiri'
require 'pry'

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  
  projects = {}
  kickstarter.css("li.project.grid_4").each do |pr|
    title = pr.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => pr.css("div.project-thumbnail a img").attribute('src').value,
      :description => pr.css("p.bbcard_blurb").text,
      :location => pr.css("ul.project-meta span.location-name").text,
      :percent_funded => pr.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  
  projects
end