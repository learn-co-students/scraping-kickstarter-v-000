# require libraries/modules here
require "nokogiri"
#require "pry"

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  # binding.pry
  # Projects: kickstarter.css("li.project.grid_4")
  # Title selector: title: project.css("h2.bbcard_name strong a").text (Moby Dick: An Oratorio)
  # Image selector: # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # Description selector: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


  projects = {} #hash

  kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("ul.project-meta span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }
    end

    projects

end
