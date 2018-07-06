require 'nokogiri'
require 'pry'

  def create_project_hash
    html = File.read('fixtures/kickstarter.html')

    kickstarter = Nokogiri::HTML(html)
    puts kickstarter.css("li.project.grid_4").first
  end


create_project_hash
