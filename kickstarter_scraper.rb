# require libraries/modules here
require 'nokogiri'


def create_project_hash
  # This just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
end
