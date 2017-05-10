# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html') #sets the imported HTML(string) equal to a variable, html

  kickstarter = Nokogiri::HTML(html) #takes the html variable and converts it into a nested node set
  #binding.pry

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project| #iterate through the projects
  title = project.css("h2.bbcard_name strong a").text #find all the titles
  projects[title.to_sym] = { #convert the title to a symbol and put it in the projects hash
    :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
    :description => project.css("p.bbcard_blurb").text,
    :location => project.css("ul.project-meta span.location-name").text,
    :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i #.gsub etc. converts to integer
  }
end

# return the projects hash
projects

  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location : project.css("ul.project-meta li a span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
end

create_project_hash
