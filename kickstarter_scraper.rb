require 'nokogiri'
require 'pry'

#projects: kickstarter.css('li.project.grid_4')
#title: project.css('h2.bbcard_name strong a').text

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css('li.project.grid_4').each {|project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      image_link: project.css('img.projectphoto-little').attribute('src').value,
      description: project.css('p.bbcard_blurb').text,
      location: project.css('.location-name').text,
      percent_funded: project.css('li.funded strong').text.delete('%').to_i
    }
  }

  projects
end

create_project_hash
