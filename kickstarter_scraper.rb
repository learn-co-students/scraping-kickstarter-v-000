# require libraries/modules here

require 'pry'
require 'nokogiri'
	
def create_project_hash
	# write your code here

	html = File.read('fixtures/kickstarter.html')
	kickstarter = Nokogiri::HTML(html)

	projects = {}
	
	kickstarter.css('li.project.grid_4').each do |project|
		title = project.css('h2.bbcard_name strong a').text
		projects[title.to_sym] = {
			:image_link => project.css("div.project-thumbnail a img").attribute("src").value,
			:description => project.css('p.bbcard_blurb').text,
			:location => project.css('li span.location-name').text,
			:percent_funded => project.css('ul.project-stats li.first.funded').text.gsub('%', '').to_i,
		}
	end
	projects
end
# binding.pry

create_project_hash

# all projects
#  projects: kickstarter.css('li.project.grid_4')
# all titles
# title : project.css('h2.bbcard_name strong a').text
# image_link: project.css("div.project-thumbnail a img").attribute("src").value
# descript: project.css('p.bbcard_blurb').text
# location: project.css('li span.location-name').text
# 'gsub('%', '') gets ride of the % and 'to_i' makes # into an inteeger
# %_funded:  project.css('ul.project-stats li.first.funded').text.gsub('%', '').to_i

