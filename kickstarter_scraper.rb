require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4").first
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css(".project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta li a span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  # iterate through all of the projects
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text

    #takes the overall projects hash and adds the individual project title as a key and sets the value to a hash with k/v pairs of the remaining data points
    projects[title.to_sym] = {
      :image_link => project.css(".project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end

  projects
end
create_project_hash
