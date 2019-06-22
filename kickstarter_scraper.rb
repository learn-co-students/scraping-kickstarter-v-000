# require libraries/modules here
require 'nokogiri'
require 'pry'

require_relative './kickstarter.html'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  
  kickstarter = Nokogiri::HTML(html)
end
binding.pry 

create_project_hash

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text 