# require libraries/modules here
require 'nokogiri'
require 'pry'
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
def create_project_hash
  #opens file and reats it to variable kickstarter
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #creates an empty general hash projects
  projects = {}
  #iterate through each project
    kickstarter.css("li.project.grid_4").each do |project|
      #project title is a key and the value is another hash with each data point as key
      title = project.css("h2.bbcard_name strong a").text
      #convert the title to symbol because symbols make better hash keys than strings
      projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i}
    end
    #return projects hash
    projects
end
