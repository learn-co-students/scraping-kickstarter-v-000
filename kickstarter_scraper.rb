require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
#binding.pry

  projects = {}

  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {    #converting title into a symbol as symbols make better hash keys than strings
      :image_link => project.css('div.project-thumbnail a img').attribute('src').value,
      :description => project.css('p.bbcard_blurb').text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css('ul.project-status li.first.funded strong').text.gsub('%', '').to_i
  }
  end

  projects
end



#projects: kickstarter.css('li.project.grid_4')
  #variable_name = _ syntax used in Pry will assign the variable name to the return value of whatever was executed above
#title: project.css('h2.bbcard_name strong a').text
#image link: project.css('div.project-thumbnail a img').attribute('src').value
    #image tags in HTML also has a source attribute; .attribute grabs the 'src' value
#description: project.css('p.bbcard_blurb').text
#location: project.css("ul.project-meta span.location-name").text
#percent_funded: project.css('ul.project-status li.first.funded strong').text.gsub('%', '').to_i

create_project_hash
