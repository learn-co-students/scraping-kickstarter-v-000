# require libraries/modules here
require "nokogiri"
require "pry"


# File.open is used instead of open-uri's "open" function since the html file is local and not being pulled from the web

# html variable holds actual file, while kickstarter variable holds html code from file

def create_project_hash
  html = File.open("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project .project-card").each do |element|
    title = element.css("h2.bbcard_name strong a").text.strip
    img_link = element.css("div.project-thumbnail a img").attr("src").value.strip
    description = element.css("p.bbcard_blurb").text.strip
    location = element.css(".location-name").text.strip
    percent_funded = element.css("li.funded strong").text.strip.gsub("%","").to_i
    projects[title.to_sym] = {
      :image_link => img_link,
      :description => description,
      :location => location,
      :percent_funded => percent_funded
    }
  end
  projects
end

create_project_hash.each do |key, hash|
  puts "#{key.to_s}  (#{key.class.to_s})"
  puts hash
  puts "\n"
end

# binding.pry
