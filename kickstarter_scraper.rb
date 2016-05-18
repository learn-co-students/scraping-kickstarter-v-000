# require libraries/modules here
require "Nokogiri"
require "pry"

def create_project_hash
  # write your code here
  html = File.read("./fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  project = kickstarter.css("li.project.grid_4")
  projects = {}
  project.each do |proj|
    title = proj.css("h2.bbcard_name strong a").text
    title = title.to_sym
    image = proj.css("div.project-thumbnail a img").attribute("src").value
    description = proj.css("p.bbcard_blurb").text
    location = proj.css("span.location-name").text
    percent_funded = proj.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

    projects[title] = {
    image_link: image,
    description: description,
    location: location,
    percent_funded: percent_funded,
  }
  end
  projects
end
