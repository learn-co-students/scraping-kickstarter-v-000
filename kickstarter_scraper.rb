# require libraries/modules here
require 'nokogiri'
def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  result = { projects: {} }
  doc = Nokogiri::HTML(html)
  doc.css('.project').each do |project_element|
  	title = project_element.css('strong > a').text.to_sym
  	result[:projects][title] = {
	  	:image_link => project_element.css('.projectphoto-little').attribute('src').value,
	  	:description => project_element.css('.bbcard_blurb').text.chomp,
		:location => project_element.css('.location-name').text,
		:percent_funded => project_element.css('.funded > strong').text.to_i
	}
  end
  result[:projects]
end