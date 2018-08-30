# require libraries/modules here
  require "nokogiri"
  require "pry"
  
def create_project_hash
 html = File.read('fixtures/kickstarter.html')
 kickstarter = Nokogiri::HTML(html)
 projects = {}
 

 kickstarter.css("li.project.grid_4").each do |project|
 title = project.css("h2.bbcard_name strong a").text 
 project[title] = {
:image_link => projects.css("div.project-thumbnail a img").attribute("src").value
  
:descprtion => projects.css("P").attribute
  
 
 }
 end
 

 
end