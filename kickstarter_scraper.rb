# require libraries/modules here. In Ruby, gems are libraries.

require 'nokogiri'
require 'pry'

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

=begin

require 'nokogiri'
require 'pry'

def create_project_hash
  #grab project list from HTML
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  project_list = kickstarter.css("li.project.grid_4")

  #scrape for project info and add to hash.These individual project hashes will be collected into a larger hash called projects.
  projects = {}
  project_list.each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text.chomp,
      location: project.css("ul.project-meta li a span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded").text.gsub("%","").to_i
    }
  end
  projects
end
=end