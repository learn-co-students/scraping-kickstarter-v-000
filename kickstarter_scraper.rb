# require libraries/modules here
require "nokogiri"
require 'pry'
#kickstarter.css("li.project.grid_4") => whole array
#project.css("h2.bbcard_name a strong a").text => project title
#project.css("div.prject-thumbnail a img").attribute("src").value => img link
#project.css("p.bbcard_blurb").text => text description
#project.css("ul span.location-name").text => Location
#project.css("li.first.funded").text => % Funded
#project.css("ul.project-stats li.pledged").text.gsub("%", "").to_i => Pledged amount $$$



def create_project_hash
  # write your code here

  html = File.read("fixtures/kickstarter.html")

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul span.location-name").text,
      :percent_funded =>project.css("ul.project-stats li.pledged").text.gsub("%", "").to_i
    }

  end
  projects
end
