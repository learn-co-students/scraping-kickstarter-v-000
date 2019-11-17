# require libraries/modules here

# scraping steps: get, make, print
# create cmobines get and make
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  project_nodes = kickstarter.css(".project-card")

  projects = Hash.new
  project_nodes.each do |project|
    title = project.css(".bbcard_name").css("a").text
    projects[title] = {
        :image_link => project.css(".project-thumbnail img").attr("src").value,
        :description => project.css(".bbcard_blurb").text,
        :location => project.css(".location-name").text,
        :percent_funded => project.css(".first.funded strong").text.gsub('%','').to_i
      }
    end
    return projects
end

def get_project_name(xml_nodes)
  xml_nodes
end

def get_project_props
end

create_project_hash
