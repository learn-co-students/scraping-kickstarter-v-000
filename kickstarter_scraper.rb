require 'nokogiri'
require 'pry'


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css(".project-card").each do |project|
    title = project.css(".bbcard_name").text
    projects[title.to_sym] = {
      :image_link => project.css(".projectphoto-little").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.chomp("%").to_i
    }
  end
  projects
end


# kickstarter.css(".project-card") - projects
# project.css(".bbcard_name").text - title
# project.css(".projectphoto-little").attribute("src").value - image_link
# project.css("p.bbcard_blurb").text - description
# project.css("span.location-name").text - location
# project.css("ul.project-stats li.first.funded strong").text
