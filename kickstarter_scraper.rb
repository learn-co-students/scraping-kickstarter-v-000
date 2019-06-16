# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
   html = File.read('fixtures/kickstarter.html')
   kickstarter= Nokogiri::HTML(html)

  #  kickstarter.css("li.project.grid_4").first.css("h2").text #title
    #  kickstarter.css("li.project.grid_4").first.css("div.project-thumbnail a img").attribute("src").value  #image
  #  kickstarter.css("li.project.grid_4").first.css("p").text  #description
  #  kickstarter.css("li.project.grid_4").first.css("ul.project-meta span.location-name").text   #location
  #  kickstarter.css("li.project.grid_4").first.css("ul.project-stats li.first.funded").text #funded

     project = {}

    kickstarter.css("li.project.grid_4").each {  |data|

              title = data.css("h2").text
              project[title.to_sym] = {  #project[:title]  =  project[title.to_sym]
                          :image_link => data.css("div.project-thumbnail a img").attribute("src").value,
                          :description => data.css("p").text,
                          :location => data.css("ul.project-meta span.location-name").text,
                          :percent_funded => data.css("ul.project-stats li.first.funded").text.gsub("%","").to_i
                }
    }


  #  binding.pry
    return project
end


#flatiron scraping
#projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
