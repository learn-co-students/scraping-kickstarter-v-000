# require libraries/modules here

require 'nokogiri'

def create_project_hash
  html=File.read('fixtures/kickstarter.html')
  kickstarter=Nokogiri::HTML(html) 
  
  projects = {}
  
  kickstarter.css("li.project.grid_4").each do |x|
  	projects[x.css("h2.bbcard_name strong a").text.to_sym] = {
  	:image_link => x.css("div.project-thumbnail a img.projectphoto-little").attribute("src").value,
  	:description => x.css("p .bbcard_blurb").text,
  	:location => x.css("ul.project-meta li a span.location-name").text,
  	:percent_funded => x.css("ul.project-stats li.first.funded strong").text.gsub(/%/,"").to_i
  	}
  end
  projects
end