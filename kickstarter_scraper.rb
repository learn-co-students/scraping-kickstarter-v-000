
require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html) ### Nokogiri inherits all methods from Ruby's HTML module, I think? and passes in the site to scrape

  projects = {} ### create a place to store every project scraped

  kickstarter.css("li.project.grid_4").each do |project| ### iterate through each individual project section

    title = project.css("h2.bbcard_name strong a").text ### scrapes the project title and stores it

    projects[title.to_sym] = { ### turns the title string into a symbol and puts it in the PROJECTS hash - the value becomes all the scraped data about the project

      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

    }

  end

  projects ### implicit return of the filled up PROJECTS hash

end
