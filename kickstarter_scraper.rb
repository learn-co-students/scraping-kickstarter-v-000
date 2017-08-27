require 'pry'
require 'nokogiri'

def create_project_hash
  # This just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = { #symbols make better hash keys than strings
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
      }
  end
  projects
  # projects: kickstarter.css("li.project.grid_4")  #why would the css selector not be ".project-card-wrap"?
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("span.location-name").text
  # percent funded:
end
