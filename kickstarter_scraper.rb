# projects: kickstarter.css("li.project.grid_4") - to help us remember selector needed!
# titles: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta li a").text or project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

require 'nokogiri'
require 'pry'

def create_project_hash

  #this opens a file and reas it into a variable
  html = File.read('fixtures/kickstarter.html')
  #this nokogiris the html file into nested nodes
  kickstarter = Nokogiri::HTML(html)

  #set empty hash of projects
  projects = {}

  #iterate through projects
  kickstarter.css("li.project.grid_4").each do |project|
    #set var title equal to the title of the kickstarter project
    title = project.css("h2.bbcard_name strong a").text
    #set project title as a key and converting the string into a symbol using .to_sym
    projects[title.to_sym] = {
      #sets keys and hash values - hash values being the information gathered by nokogiri
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a").text.gsub("\n", ""),
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  #returns the projects hash
  # binding.pry
  projects

end

create_project_hash
