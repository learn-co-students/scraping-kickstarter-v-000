require 'pry'
# require 'fixtures/kickstarter.html'
require 'nokogiri'
require 'open-uri'

def create_project_hash
  result = {}
  file = File.read("./fixtures/kickstarter.html")
  html = Nokogiri::HTML(file)
  projects = html.css(".project-card")
  projects.each do |project|
    title = project.css("h2 strong a")[0].text
    result[title] = {
      :image_link => project.css(".project-thumbnail a img")[0].attributes['src'].value,
      :description => project.css("p")[0].text,
      :location => project.css(".location-name")[0].text,
      :percent_funded => project.css(".funded strong")[0].text.to_i,
    }
  end
  result
end
