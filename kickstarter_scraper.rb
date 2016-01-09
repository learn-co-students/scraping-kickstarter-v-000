require 'nokogiri'
require 'open-uri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  projects = {}


  kickstarter.css(".project-card").each{|project|
    title = project.css("h2.bbcard_name strong a").text.to_sym
    projects[title] = {
      :image_link => project.css(".project-thumbnail a img").attribute('src').value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first a strong").text.gsub("%", "").to_i
      }
    }

  projects
end