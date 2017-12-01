require 'nokogiri'
require 'pry'

# The selector is 'projects: kickstarter.css("li.project.grid_4")'
# The title is '# title: project.css("h2.bbcard_name strong a").text'
# The image link is '# image link: project.css("div.project-thumbnail a img").attribute("src").value'
# The description is 'project.css("p.bbcard_blurb").text'
# The course location is 'project.css("span.location-name").text'
# The amount funded is 'project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i'
def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end

  projects
end
