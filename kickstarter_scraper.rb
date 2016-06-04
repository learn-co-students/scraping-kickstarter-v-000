require "pry"
require "nokogiri"

def create_project_hash
  # This just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css(".project.grid_4").each do |project|
    title = project.css(".bbcard_name strong a").text

    projects[title.to_sym] = {
      image_link:     project.css(".project-thumbnail a img").attribute("src").value,
      description:    project.css(".bbcard_blurb").text.delete!("\n"),
      location:       project.css(".location-name").text,
      percent_funded: project.css(".first.funded strong").text.gsub("%", "").to_i
    }
  end

  projects
end
