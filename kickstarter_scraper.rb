require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css(".bbcard_name strong a").text
    projects[title] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text.strip,
      location: project.css("span.location-name").text,
      percent_funded: project.css("li.first.funded strong").text.gsub("%", "").to_i
    }
  end
  projects
end

#projects: kickstarter.css("li.project.grid_4")
#title: project.css(".bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
#location: project.css("span.location-name").text
#percent funded: project.css("li.first.funded strong").text.gsub("%", "").to_i

# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }

