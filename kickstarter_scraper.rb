# require libraries/modules here
require 'nokogiri'
require 'pry'
#projects: kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css(".location-name").text
# percent funded: project.css("ul.project-stats li.first.funded strong").gsub("%", "").to_i



def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text.strip,
      :location => project.css(".location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end
  projects
end

puts create_project_hash

# Just a couple formatting notes.  I realized that the description text was coming with the return
# symbols \n attached to both ends, and therefore I used the strip method to remove those returns.
# However, there were some descriptions that had escape keys in the middle.  How do I fix?
# example: "Two new urban fantasy novellas featuring half-fatae PI Danny Hendrickson: \"The Work of Hunters\" and \"An Interrupted Cry\""