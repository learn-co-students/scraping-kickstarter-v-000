# require libraries/modules here
require 'pry'
require 'nokogiri'

def create_project_hash
  # write your code here
  # each project has the following: 
  project_hash = Hash.new
    # image:image_link,
    project_hash["image"] = "https://s3.amazonaws.com/ksr/projects/845788/photo-little.jpg?1391022013"
    project_hash["description"] = kickstarter.css(".bbcard_blurb").first.css("p").text
  binding.pry
    # title:description, 
    # description:string, 
    # location:string 
  

  # set of key value pairs 
  
  html = File.read('fixtures/kickstarter.html')
 
  kickstarter = Nokogiri::HTML(html)
 
end

create_project_hash