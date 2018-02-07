# require libraries/modules here
#projects: kickstarter.css("li.project.grid_4")
#titles: project.css("h2.bbcard_name strong a").text
#imagelinks: project.css("div.project-thumbnail a img").attribute("src").value
#Dis: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta span.location-name").text
#Percent Funded: project.css("ul.project-stats li.funded strong").text.gsub("%","").to_i  #gsub("%","").to_i: It removes % sign and converts digits to int If we want to perform math on it in future
require "nokogiri"
require "pry"
def create_project_hash
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)

    projects = {}

      kickstarter.css("li.project.grid_4").each do |project|
        title = project.css("h2.bbcard_name strong a").text
        projects[title.to_sym] = {
          :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
          :description => project.css("p.bbcard_blurb").text,
          :location => project.css("ul.project-meta span.location-name").text,
          :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
            }
      end

        #returns the projects hash
        projects

end
