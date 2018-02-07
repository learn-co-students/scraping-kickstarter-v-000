require 'pry'
require 'nokogiri'

def create_project_hash
  @all_projects = {}

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css("li.project.grid_4")

  projects.each do |project|
    title = project.css("h2 strong a").text
    @all_projects[title.to_sym] = {
           :image_link => project.css("div.project-thumbnail img").attribute("src").value,
          :description => project.css(".bbcard_blurb").text, 
             :location => project.css(".location-name").text,
       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end

  @all_projects
end