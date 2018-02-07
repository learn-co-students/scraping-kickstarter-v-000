require 'nokogiri'
# require 'open-uri' this gem is only needed when opening a live website
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html') # Opens a file and reads it into a variable. File is large
  # and only allows iteration (see below) to partially pull information from the first five(5) projects.
  kickstarter = Nokogiri::HTML(html)
  # kickstarter = Nokogiri::HTML(File.open('fixtures/kickstarter-02.html')) # Opens a smaller file and iterates
  # through all projects. Does not need above lines of code.

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project| # Partially iterates through the projects located at "...grid_4"
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
    #binding.pry
  end
  projects
  #binding.pry
end

create_project_hash
