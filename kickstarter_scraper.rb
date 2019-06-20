#!/usr/bin/env ruby

require 'nokogiri'
require 'pry'
def create_project_hash
  html =File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project.grid_4").each do |project|
      # projects: kickstarter.css("li.project.grid_4")
    title = project.css("h2.bbcard_name strong a").text
          # title: project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
          # image link: project.css("div.project-thumbnail a img").attribute("src").value
        :description => project.css("p.bbcard_blurb").text,
          # description: project.css("p.bbcard_blurb").text
        :location => project.css("ul.project-meta span.location-name").text,
          # location: project.css("ul.project-meta span.location-name").text
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
          # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
        }
      end
      projects
end
