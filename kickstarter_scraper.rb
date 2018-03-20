require 'pry'
# require 'fixtures/kickstarter.html'
require 'nokogiri'
require 'open-uri'

def create_project_hash
  result = {}
  projects = Nokogiri::HTML(File.read("./fixtures/kickstarter.html")).css(".project-card")
  projects.each do |project|
    title = project.css("h2 strong a")[0].text
    result[title] = {}
    result[title][:image_link] = project.css(".project-thumbnail a img")[0].attributes['src'].value
    result[title][:description] = project.css("p")[0].text
    result[title][:location] = project.css(".location-name")[0].text
    result[title][:percent_funded] = project.css(".funded strong")[0].text.to_i
  end
  result
end
