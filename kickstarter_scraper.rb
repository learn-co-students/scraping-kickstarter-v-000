# require libraries/modules here
require "nokogiri"
require "pry"

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text ** returns the description of a project, if it called on all projects, it will return the description of all of the projects
#location name: project.css("ul.project-meta span.location-name").text
#percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = {}
  #iterate through the projects
  kickstarter.css("li.project.grid_4").each do|project|
    title = project.css("h2.bbcard_name strong a").text
    #this creates a nested hash for each project named after the title. ex :"Moby Dick: An Oratorio" => {}
    #to_sym changes the title to a symbol
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end

  projects
end

create_project_hash
