require 'nokogiri'
require 'pry'

=begin
projects  kickstarter.css("li.project.grid_4")
title   project.css("h2.bbcard_name strong a").text
image_link    project.css("div.project-thumbnail a img").attribute("src").value
description   project.css("p.bbcard_blurb").text
location    project.css("span.location-name").text
percentage   project.css("li.first.funded strong").text.gsub("%", "").to_i

:projects => {
  "My Great Project"  => {
    :image_link => "Image Link",
    :description => "Description",
    :location => "Location",
    :percent_funded => "Percent Funded"
  }
}
=end

def create_project_hash
  kickstarter = Nokogiri::HTML(File.open('fixtures/kickstarter.html'))

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("span.location-name").text,
      percent_funded: project.css("li.first.funded strong").text.to_i
    }
  end
  projects
end
