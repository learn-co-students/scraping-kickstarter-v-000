require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = kickstarter.css("li.project.grid_4")
  projects_hash = {}

  projects.each do |project|
    projects_hash[project.css("h2.bbcard_name strong a").text] = {
      image_link: project.css("div.project-card div.project-thumbnail a img").attr("src").value,
      description: project.css("div.project-card p.bbcard_blurb").text,
      location: project.css("div.project-card ul.project-meta li a span.location-name").text,
      percent_funded: project.css("div.project-card ul.project-stats li.first.funded strong").first.text.gsub("%", "").to_i
    }
  end

  # binding.pry
  projects_hash
end


create_project_hash




# titles = projects.css("h2.bbcard_name strong a").text
# image_links = projects.css("div.project-card div.project-thumbnail a img").attr("src").value
# description = projects.css("div.project-card p.bbcard_blurb").text
# location = projects.css("div.project-card ul.project-meta li a span.location-name").text
# percent_funded = projects.css("div.project-card ul.project-stats li.first.funded strong").first.text.gsub("%", "").to_i
