require 'nokogiri'

def create_project_hash
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
  project_hash = {}
  projects = kickstarter.css("li.project.grid_4")
  projects.each do |project|
    title = project.css("h2.bbcard_name strong a").text.to_sym
    project_hash[title] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("ul.project-meta li a span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end
  project_hash
end