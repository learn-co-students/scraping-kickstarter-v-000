require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


def create_project_hash
  html = File.read('fixtures/kickstarter.html') # Needed since it is not a live webpage
  kickstarter = Nokogiri::HTML(html) #use the above line instead of "open" of open-uri in case of live pages

  projects = {} #Creates an empty projects hash

  kickstarter.css("li.project.grid_4").each do |project| #runs loop for each project
    title = project.css("h2.bbcard_name strong a").text #scrapes the title text for each project
    projects[title.to_sym] = { #uses the title text as a key to each individual project after conv. to sym.
      #assigns the key-value pair to sub-level hash for each project
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  #returns the project hash
  projects
end
