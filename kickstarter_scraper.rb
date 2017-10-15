# require libraries/modules here
require 'nokogiri'
def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  array = kickstarter.css("li.project.grid_4")
  projects = {}
  array.each do |post|
    title = post.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: post.css("div.project-thumbnail a img").attribute("src").value,
      description: post.css("p.bbcard_blurb").text,
      location: post.css("ul.project-meta span.location-name").text,
      percent_funded: post.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end
