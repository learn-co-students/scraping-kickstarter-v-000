require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css("li.project.grid_4").each do |pjt|
    title = pjt.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => pjt.css("div.project-thumbnail a img").attribute("src").value,
      :description => pjt.css("p.bbcard_blurb").text,
      :location => pjt.css("ul.project-meta span.location-name").text,
      :percent_funded => pjt.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end

  projects

end
