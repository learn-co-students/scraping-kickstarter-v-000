require 'nokogiri'
require 'pry'

def create_project_hash
#  html = open("fixtures/kickstarter.html")
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  #projects = {} #title => {image: , description: , location: , percentage_funded: } 

#  projects = kickstarter.css(".project-card")
#  titles = project.css("a").text
#  description = project.css(".p.bbcard-blurb").text
#  image = project.css(".project-thumbnail").attribute("src").value
#  location = project.css("li").text
#  percentage_funded = project.css(".funded").text

  projects = {}

  kickstarter.css("div.project-card").each do |project|
#    binding.pry
    projects[project.css("h2.bbcard_name strong a").text.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css(".p.bbcard-blurb").text,
      :location => project.css("ul.prject-meta span.location-name").text,
      :percent_funded => project.css("ul.prject-meta li.first.funded").text.gsub("%","").to_i
    }
  end
  
  projects

end