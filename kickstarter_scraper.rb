# require libraries/modules here
require 'nokogiri'
require 'open-uri'
require 'pry'
def create_project_hash
  doc = Nokogiri::HTML(open('./fixtures/kickstarter.html'))
  projects = {}

  doc.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      image_link: project.css('div.project-thumbnail a img').first.attr('src'),
      description: project.css("p.bbcard_blurb").text,
      location: project.css("ul.project-meta span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end
