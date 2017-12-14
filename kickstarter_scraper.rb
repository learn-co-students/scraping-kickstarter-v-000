# require libraries/modules here
require 'pry'
require 'nokogiri'

def create_project_hash
  # write your code here
  
  html = File.read('fixtures/kickstarter.html')
 
  kickstarter = Nokogiri::HTML(html)
  # each project has the following: 
  project_hash = Hash.new
    # image:image_link,
  project_hash["image"] = kickstarter.css(".projectphoto-little").attribute("src").value
    # title:???
  
    # description:string
  project_hash["description"] = kickstarter.css(".bbcard_blurb").first.text
    # location:string
  project_hash["location"] = kickstarter.css(".location-name").first
  
  binding.pry
  
  

  # set of key value pairs 
 
end

create_project_hash