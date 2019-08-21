#==================require=====================
require 'nokogiri'
require 'pry'
#==============================================

def create_project_hash
#==============================================
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
#==============================================  
  kickstarter.css("li.project.grid_4").each{|p|
    title = p.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :title => p.css("h2.bbcard_name strong a").text,
      :image_link => p.css("div.project-thumbnail a img").attribute("src").value,
      :description => p.css("p.bbcard_blurb").text,
      :location => p.css("ul.project-meta li a span").text,
      :percent_funded => p.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  }
#==============================================
  projects
end







