# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

#projects: kickstarter.css('li.project.grid_4')
#title: projects.css("h2.bbcard_name strong a").text
#image link: projects.css('div.project-thumbnail a img').attribute('src').value
#description: projects.css('.bbcard_blurb').text
#location: projects.css('.project-meta li a').text
#funded: projects.css('.first.funded strong').text.to_i
  projects = {}
  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css('div.project-thumbnail a img').attribute('src').value,
      :description => project.css('.bbcard_blurb').text,
      :location => project.css('.project-meta span.location-name').text,
      :percent_funded => project.css('.first.funded strong').text.gsub('%','').to_i
    }
  end
  projects
end

create_project_hash.each do |k,v|
  puts "Project: #{k}"
  puts "  Image Link: #{v[:image_link]}"
  puts "  Description: #{v[:description]}"
  puts "  Location: #{v[:location]}"
  puts "  Funded: #{v[:funded]}"
end
