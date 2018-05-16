# require libraries/modules here
require "nokogiri"

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("#projects_list .project.grid_4").each do |project_card|
    title = project_card.css(".bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project_card.css(".project-thumbnail a img").attribute("src"),
      description: project_card.css(".bbcard_blurb").text,
      location: project_card.css(".project-meta span.location-name").text,
      percent_funded: project_card.css(".project-stats .first.funded strong").text.to_i
    }
  end
  projects
end
