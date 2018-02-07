require 'nokogiri'
require 'open-uri'

def create_project_hash

  projects = {}
  kickstarter = Nokogiri::HTML(open("fixtures/kickstarter.html"))

  kickstarter.css("li.project.grid_4").each {|x|
    title = x.css(".bbcard_name a").text
    projects[title.to_sym] ={
      image_link: x.css("div.project-thumbnail a img").attribute("src").value,
      description: x.css("p.bbcard_blurb").text,
      location: x.css("span.location_name").text,
      percent_funded: x.css(".first.funded strong").text.gsub("%","").to_i
    }
  }
  projects
end
