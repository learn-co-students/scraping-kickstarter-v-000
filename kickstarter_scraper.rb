require "nokogiri"
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css('li.project.grid_4')
  # title: project.css('h2.bbcard_name strong a')
  # image link: project.css('.project-thumbnail a img').attribute('src').value
  #description: project.css('p.bbcard_blurb').text.strip
  #location: project.css('ul.project-meta span.location-name').text
  #percent_funded: project.css('ul.project-stats li.first.funded strong').text.gsub('%',"").to_i


end

create_project_hash
