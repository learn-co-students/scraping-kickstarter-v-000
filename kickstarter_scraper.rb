require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

  def create_project_hash
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)

    projects ={} # create an empty array to put all the orginized data into later

    kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = { #converting the title into a symbol using the to_sym method.

        # Below we grab each of the data points using the selectors we've already figured out, and adding them to each project's hash.

        image_link: project.css("div.project-thumbnail a img").attribute("src").value,
        description: project.css("p.bbcard_blurb").text,
        location: project.css("ul.project-meta span.location-name").text,
        percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }
    end
    projects
  end
