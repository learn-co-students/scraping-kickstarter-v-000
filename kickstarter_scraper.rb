require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css('li.project.grid_4').each do |project|

    title = project.css('.bbcard_name > strong').text
    projects[title.to_sym] = {
      :image_link => project.css('img.projectphoto-little').attribute('src').value,
      :description => project.css('p.bbcard_blurb').text,
      :location => project.css('span.location-name').text,
      :percent_funded => project.css('li.funded').text.gsub("%","").to_i
    }
  end

  projects
end