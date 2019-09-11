require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
  	title = project.css("h2.bbcard_name strong").text
  	projects[title.to_sym] = {
  		:image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  		:description => project.css("p.bbcard_blurb").text,
  		:location => project.css(".location-name").text,
  		:percent_funded => project.css(".funded strong").text.gsub("%", "").to_i

  	}
	end

  projects
end

puts create_project_hash

# projects: kickstarter.css("li.project.grid_4")
# titel: project.css("h2.bbcard_name strong a").text
# image: project.css("div.project-thumbnail a img").attribute("src").value
# project.css("p.bbcard_blurb").text
# location: project.css(".location-name").text

# %funded :roject.css(".funded strong").text.gsub("%", "").to_i