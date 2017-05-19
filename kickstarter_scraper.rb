require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #projects:

  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # descp: project.css("p.bbcard_blurb").text
  # location: project.css(".location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

  projects ={}

  kickstarter.css("li.project.grid_4").each do
    |proj|
    title = proj.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => proj.css("div.project-thumbnail a img").attribute("src").value,
      :description => proj.css("p.bbcard_blurb").text,
      :location => proj.css(".location-name").text,
      :percent_funded => proj.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }
  end
  projects
end

create_project_hash
