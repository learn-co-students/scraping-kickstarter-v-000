require 'pry'
require 'nokogiri'

html = File.read('fixtures/kickstarter.html')

kickstarter = Nokogiri::HTML(html)

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|  #iterate over each project
    title = project.css("h2.bbcard_name strong a").text
    #symbols are unchangeable so they make for better hash keys than strings
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  # return the projects hash
  projects
end
#binding.pry
