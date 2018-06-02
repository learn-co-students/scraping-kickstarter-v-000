# require libraries/modules here
require 'nokogiri'
require "pry"

def create_project_hash
  # write your code here
  html=File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #projects: kickstarter.css('li.project.grid_4')
  #title: project.css('h2.bbcard_name strong a').text
  #imagelink: project.css('div.project-thumbnal a img').attribute('src').value
  #description: project.css('p.bbcard_blurb').text
  #location: project.css('span.location-name').text
  #percent funded: project.css('ul.project-stats li.first.funded strong').text.gsub("%","").to_i
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project| #get the projects from parsed HTML node list, do with each...
    title=project.css('h2.bbcard_name strong a').text #go grab ahold of the title from the html node list
    projects[title.to_sym]={
      :image_link => project.css('div.project-thumbnail a img').attribute('src').value,
      :description => project.css('p.bbcard_blurb').text,
      :location =>  project.css('span.location-name').text,
      :percent_funded => project.css('ul.project-stats li.first.funded strong').text.gsub("%","").to_i
    } #initialize a project hash within projects hash whose key is the project's title symbol-ized

  end

  projects


end
