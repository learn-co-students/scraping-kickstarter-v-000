require 'pry'
# require 'fixtures/kickstarter.html'
require 'nokogiri'
require 'open-uri'

def create_project_hash
  result = {}
  xml_projects = Nokogiri::HTML(File.read("./fixtures/kickstarter.html"))
  xml_projects.css(".project-card").each do |project|
    # binding.pry
    result[:image_link] = project.css(".project-thumbnail a img")[0].attributes['src'].value
    # result.schedule = post.css(".date").text
    # result.description = post.css("p").text
  end
  result
end




#   def get_courses
#     self.get_page.css(".post")
#   end
#
#   def make_courses
#     self.get_courses.each do |post|
#       course = Course.new
#       course.title = post.css("h2").text
#       course.schedule = post.css(".date").text
#       course.description = post.css("p").text
#     end
#   end
