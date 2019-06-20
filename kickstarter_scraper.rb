# require libraries/modules here
require "nokogiri"
require "pry"
def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects={}

  page_section = kickstarter.css("li.project.grid_4")

  page_section.each do |project|
    title=project.css("h2.bbcard_name strong a").text
    projects[title.to_sym]={
      image_link: project.css(".project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css(".project-meta .location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
    end

  projects
 end

create_project_hash
