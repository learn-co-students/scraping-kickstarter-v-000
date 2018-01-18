require "nokogiri"

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    projects[project.css("h2.bbcard_name strong a").text.to_sym] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").
                  value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("span.location-name").text,
      percent_funded: project.css("li.first.funded strong").text.chop.to_i
    }
  end

  projects
end
