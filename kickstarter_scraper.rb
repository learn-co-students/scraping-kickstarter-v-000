# require libraries/modules here
require 'pry'
require 'nokogiri'


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
 
  # return the projects hash
  projects
end

  
  #  my code below ****
  # each project has the following: 
#  project_hash = Hash.new
#  project_array = kickstarter.css(".project")
#  my code below ****
#  project_array.each do |p|
#    title = kickstarter.css(".bbcard_name").first.text
#    project_hash[title.to_sym] = {
#    # image:image_link,
#    project_hash["image"] => kickstarter.css(".projectphoto-little").attribute("src").value,
#      # title:project_title
#    project_hash["title"] = kickstarter.css(".bbcard_name").first.text,
#      # description:string
#    project_hash["description"] = kickstarter.css(".bbcard_blurb").first.text,
#      # location:string
#    project_hash["location"] = kickstarter.css(".location-name").first.text,
#      # percentage:percentage funded
#    project_hash["percentage"] = kickstarter.css(".funded").first.text
#      }
#  end

  # set of key value pairs 
