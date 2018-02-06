# require libraries/modules here
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
  projects
end

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


  #   kickstarter = {}#{project_title => {image_link => "", description => "", location => "", percent_funded => ""} #not sure about ""
  # #   binding.pry



# create_project_hash
#   kickstarter = kickstarter.new
# end

#Should this be meta programming using send keyword for the values?
# doc.css(".project-card").each do |project|
#   # binding.pry
# end
# kickstarter.image = doc.css("img").text
# kickstarter.description = doc.css(".bbcard_blurb").text
# kickstarter.location = doc.css(".ss-icon ss-location").text
# kickstarter.percentage = doc.css(".first funded").text
