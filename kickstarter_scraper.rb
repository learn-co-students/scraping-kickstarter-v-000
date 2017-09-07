require 'pry'
require 'nokogiri'
# require libraries/modules here

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

#PROJECTS -- kickstarter.css("li.project.grid_4") = projects

#TITLES -- projects[0].css("h2.bbcard_name strong a").text

#IMAGELINKS -- images = projects.css("div.project-thumbnail a img")
# images.collect {|x| x.attribute("src").value} => array of image links (can #join)

# BUT in terms of each:
# projects[0].css("div.project-thumbnail a img").attribute("src").value => first image source
# projects[1].css("div.project-thumbnail a img").attribute("src").value => next image source
# AND SO ON

#DESCRIPTIONS -- projects[0].css("div.project-card p.bbcard_blurb").text

#LOCATIONS -- projects[0].css("a span.location-name").text

#PERCENT FUNDED -- projects[0].css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i


def create_project_hash
  html = File.read("fixtures/kickstarter.html")

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  list_of_projects = kickstarter.css("li.project.grid_4")

  list_of_projects.each do |nokogiri_project|
    title = nokogiri_project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
        :image_link => nokogiri_project.css("div.project-thumbnail a img").attribute("src").value,
        :description => nokogiri_project.css("div.project-card p.bbcard_blurb").text,
        :location => nokogiri_project.css("a span.location-name").text,
        :percent_funded => nokogiri_project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
      }
  end
  projects
end


create_project_hash
