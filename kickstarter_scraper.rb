# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects_list = kickstarter.css('li.project.grid_4')
  projects_hash = {}

  root = '.project-card-wrap '
  name_path = root + 'strong a'
  img_path = root + 'img'
  desc_path = root + 'p.bbcard_blurb'
  loc_path = '.project-card-wrap .project-meta span.location-name'
  funds_path = root + 'li.first.funded strong'

  projects_list.each do | project |
    #attributes
    name = project.css(name_path).text
    img = project.css(img_path).attribute('src').value
    desc = project.css(desc_path).text
    loc = project.css(loc_path).text
    funds = project.css(funds_path).text.split('')
    funds.pop()
    funds = funds.join.to_i
    #hash object
    projects_hash[name] = { }
    projects_hash[name][:image_link] = img
    projects_hash[name][:description] = desc
    projects_hash[name][:location] = loc
    projects_hash[name][:percent_funded] = funds
  end

  #to get the name of each project
  #.css('.project-card-wrap strong a').text

  #to get the image link of each project
  #.css('project-card-wrap img').attribute('src').value

  #to get the description
  #.css('.project-card-wrap p.bbcard_blurb').text

  #to get location
  #.css('.project-card-wrap span').text

  #to get funds raiseed
  #.css('.project-card-wrap li.first.funded strong').text
  projects_hash
end
create_project_hash
