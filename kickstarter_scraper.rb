# require libraries/modules here
#projects: kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta span.location-name").text
#percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
require 'nokogiri'
require 'pry'

def create_project_hash
    html = File.read('fixtures/kickstarter.html') #if you were using open-uri this is wehre you'd open the webpageand get all the htmla data.
    kickstarter = Nokogiri::HTML(html) #passes in your html as an argument to Nokogiri::HTML which creates XML elements that you can iterate over.

    projects = {}

    kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        image_link: project.css("div.project-thumbnail a img").attribute("src").value,
        description: project.css("p.bbcard_blurb").text,
        location: project.css("ul.project-meta span.location-name").text,
        percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
      }

    end

    projects
end

create_project_hash
