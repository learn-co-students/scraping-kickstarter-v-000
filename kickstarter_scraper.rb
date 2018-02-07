require 'nokogiri'
require 'pry'
# require libraries/modules here

#def create_project_hash
#  html = File.read('fixtures/kickstarter.html')
#  kickstarter = Nokogiri::HTML(html)
#  binding.pry
#end
  # Iterate through the projects

  def create_project_hash
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)

    projects = {}

    kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
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

# create_project_hash
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# pry(main)> project.css("div.project-thumbnail a img").attribute("src").value
# project.css("p.bbcard_blurb").text
# project.css("span.location-name").text
# project.css("li.first.funded strong").text.text.gsub("%","").to_i                   THEIR ANSWER #=> project.css("ul.project-stats li.first.funded strong").text.text.gsub("%","").to_i
