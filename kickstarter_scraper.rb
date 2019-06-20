require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css("li.project.grid_4").each do |element|
    title = element.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => element.css("div.project-thumbnail a img").attribute("src").value,
      :description => element.css("p.bbcard_blurb").text,
      :location => element.css("ul.project-meta span.location-name").text,
      :percent_funded => element.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

    }
  end
  projects

end




# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css(".location-name").text
# project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
