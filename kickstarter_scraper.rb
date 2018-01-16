require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = kickstarter.css("li.project.grid_4")
  #binding.pry
  project_hash = {}

  projects.each do |project|
    project_hash[project.css(".bbcard_name strong a").text.to_sym] = {
      image_link: project.css(".project-thumbnail a img").attribute("src").value,
      description: project.css(".bbcard_blurb").text,
      location: project.css(".location-name").text,
      percent_funded: project.css(".project-stats li.first.funded strong").text.to_i
    }
  end
  project_hash

end

def print_hash
  project_hash = create_project_hash

  project_hash.each do |project, info|
    puts "Title: #{project}"
    puts "  Description: #{info[:description]}"
    puts "  Location: #{info[:location]}"
    puts "  Percent funded: #{info[:percent_funded]}\n\n"
  end
end

print_hash
