require 'nokogiri'
require 'pry'
# require libraries/modules here

  def create_project_hash

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  end
binding.pry
create_project_hash

#projects:
#kickstarter.css("li.project.grid_4")
