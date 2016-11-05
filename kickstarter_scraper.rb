# require libraries/modules here
require 'nokogiri'

def create_project_hash
  r={}
  doc=Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  doc.css(".project.grid_4").each do |proj|
    r[proj.css("h2 strong a").text]={
       image_link: proj.css("img.projectphoto-little").attribute("src").value,
       description: proj.css("p").text,
       location: proj.css(".location-name").text,
       percent_funded: proj.css(".first funded strong").text.to_i
    }
  end
  r


  # write your code here
end
