require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('./fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  #will need to iterate through the page we are parsing to create a hash with several keys such as imagelink,
  #description, location, % funded, and amount funded
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i,
      :amount_funded => project.css("li.pledged span.money.usd.no-code").text.gsub(/[$,]/, "").to_i
    }
    # binding.pry
  end
  projects
end
