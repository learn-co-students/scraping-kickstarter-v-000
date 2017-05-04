require_relative '../config/environment.rb'

def create_project_hash
  projects = {}
  #  File.read('/Users/FEAR/Development/code/scraping-kickstarter-v-000/fixtures/kickstarter.html')
  raw_html =  File.read('fixtures/kickstarter.html')
  noko_html = Nokogiri::HTML(raw_html)


  noko_html.css(".project-card").each {|project_card|
                                      
                                      projects[project_card.css(".bbcard_name strong a").text.to_sym] =
                                                 {
                                                  :image_link => project_card.css(".project-thumbnail a img").attribute("src").value,
                                                  :description => project_card.css(".bbcard_blurb").text,
                                                  :location => project_card.css(".project-meta .location-name").text,
                                                  :percent_funded => project_card.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
                                                  }
                                      }

#projects.each {|title,detail_hash| puts detail_hash[:percent_funded]}
projects
end

create_project_hash