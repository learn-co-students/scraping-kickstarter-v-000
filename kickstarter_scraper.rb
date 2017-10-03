require 'nokogiri'
require 'pry'
# require libraries/modules here

  def create_project_hash

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}


  #Iterate through projects

  kickstarter.css("lil.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {}
  end

  #return the projects hash

  projects

end


  end

create_project_hash

#projects:
#kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
#image link:
#project.css("div.project-thumbnail a img").attribute("src").value
#description:
#project.css("p.bbcard_blurb").text
#location:
#project.css("span.location-name").text
#percent funded:
#project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
