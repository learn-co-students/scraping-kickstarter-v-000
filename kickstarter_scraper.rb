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

  #project = kickstarter.css('li.project.grid_4')

  projects = {}

  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      :image_link => project.css('.project-thumbnail a img').attribute('src').value,
      :description => project.css('p.bbcard_blurb').text.strip,
      :location => project.css('ul.project-meta span.location-name').text,
      :percent_funded => project.css('ul.project-stats li.first.funded strong').text.gsub('%',"").to_i
    }
  end

  projects

end

create_project_hash
