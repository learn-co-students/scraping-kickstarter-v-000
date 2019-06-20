# require libraries/modules here
require 'nokogiri'
require 'open-uri'
require 'pry'


def create_project_hash
      # write your code here
      # This just opens a file and reads it into a variable
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)
    all_projects = {}  #captial will make it a class
       kickstarter.css("li.project.grid_4").each do |project|
                        title = project.css("h2.bbcard_name strong a").text
                        # each key value pair inside of the hash seprated witha commer
                        all_projects[title.to_sym] = {
                        projects: kickstarter.css("li.project.grid_4"),
                        :title => project.css("h2.bbcard_name strong a").text,
                        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
                        :description => project.css("p.bbcard_blurb").text,
                        :location => project.css("ul.project-meta span").text,
                        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
                      }

               end
        all_projects
  end
