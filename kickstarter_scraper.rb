require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  
  projects = {}

  kickstarter.css('#projects_list .project').each do |project|
    project_title = project.css('.bbcard_name strong a').text
    projects[project_title] = {
      image_link: project.css('.projectphoto-little').attribute('src').value,
      description: project.css('.bbcard_blurb').text,
      location: project.css('.location-name').text,
      percent_funded: project.css('.funded strong').text.to_i
    }
  end

  projects
end