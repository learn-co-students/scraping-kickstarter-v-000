require "nokogiri"
require "pry"

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  project_hash = {}
 
  kickstarter.css("li.project").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    project_hash[title.to_sym] = {
      image_link: project.css("div.project-thumbnail img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("span.location-name").text,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  binding.pry
  project_hash
  
end