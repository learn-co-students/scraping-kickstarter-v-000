# require libraries/modules here
require 'nokogiri'
require 'pry'
    #attr_accessor :projects, :image_link, :description, :location, :percent_funded
    #:projects: kickstarter.css("li.project.grid_4")
    #title: project.css("h2.bbcard_name strong a").text
    # title: "the title of each project lives inside a h2 tag with a class of
    #bbcard_name, inside a strong tag, and then a a tag. "
    #image: project.css("div.project-thumbnail a img").attribute("src").value
    #description: project.css("p.bbcard_blurb").text
    #location: project.css("span.location-name").text
    #percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
def create_project_hash

  # This just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')
  #this is how we read the html from a file saved locally. no need to use open method here
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    #we define a title for each project
    title = project.css("h2.bbcard_name strong a").text
    #we convert the title to a symbol and set is as the key for the project
    projects[title.to_s] = {
      #we assign the attributes as key, value pairs within a hash (nested hash)
      #an img link has an attibute titled (src) that we extract the value from
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("span.location-name").text,
      #we convert the percent funded to an integer for manipulation later on
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end
create_project_hash
