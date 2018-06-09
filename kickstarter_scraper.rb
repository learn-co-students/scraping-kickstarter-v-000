require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  Kickstarter = Nokogiri::HTML(html)

end


binding.pry
