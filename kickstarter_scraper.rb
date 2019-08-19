require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #projects: kickstarter.css("li.project.grid_4")
  #title: project.css("h2.bbcard_name strong a").text
end

create_project_hash
