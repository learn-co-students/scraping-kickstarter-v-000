require 'pry'

html = File.read('fixtures/kickstarter.html')

kickstarter = Nokogiri::HTML(html)

binding.pry
def create_project_hash
  # write your code here
end