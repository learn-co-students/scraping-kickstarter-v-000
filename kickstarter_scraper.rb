# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  #binding.pry
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
   projects

  # projects = kickstarter.css(".project-card")
  # big_project_hash={}
  # projects.each do |project|
  #   project_hash = {}
  #   title = project.css("a").text
  #   big_project_hash[title] = project_hash
  #   big_project_hash[title][:location] = project.css(".location-name").text
  #   big_project_hash[title][:description] = project.css("p").text
  #   big_project_hash[title][:image_link] = project.css("div.project-thumbnail a img").attribute("src").value
  #   big_project_hash[title][:percent_funded] = project.css(".first-funded").text.gsub("%", "").to_i
  #
  # end
  # big_project_hash
end

create_project_hash
