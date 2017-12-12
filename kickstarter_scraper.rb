require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  
  kickstarter = Nokogiri::HTML(html)
  kickstarter.css("li.project.grid_4").inject({}) do |memo, project_element|
    memo[get_project_title(project_element)] = get_project_hash(project_element)
    memo
  end
end

def get_project_title(project_element)
  project_element.css(".bbcard_name a").text
end

def get_project_hash(project_element)
  {
    image_link: get_image_link(project_element),
    description: get_description(project_element),
    location: get_location(project_element),
    percent_funded: get_percent_funded(project_element)
  }
end

def get_image_link(project_element)
  project_element.css("img.projectphoto-little").attribute("src").text
end

def get_description(project_element)
  project_element.css(".bbcard_blurb").text
end

def get_location(project_element)
  project_element.css(".location-name").text
end

def get_percent_funded(project_element)
  project_element.css("li.funded strong").text.to_i
end
