require 'nokogiri'
require 'pry'

def create_project_hash
    # tells nokogiri where the file or web page to be opened is
    html = File.read('fixtures/kickstarter.html')
    #The Nokogiri::HTML construct takes in the opened file's contents and wraps it in a special Nokogiri data object.
    #then assigns into a variable called kickstarter
    kickstarter = Nokogiri::HTML(html)
    #create empty projects hash, which we will fill up with scraped data
    projects = {}
      # Iterate through the projects (each project element)
      #each project title is a key, and the value is another hash with each of our other data points eg. :"Moby Dick:An Oratorio" => {}, :"Alpha Males"=>{}, etc.
      #convert the title into a symbol with the to_sym method. Symbols make better hash keys than strings.
      #grab each of the data points using the selectors we've already figured out, and add them to each project's hash (nested hash)
      kickstarter.css("li.project.grid_4").each do |project|
        title = project.css("h2.bbcard_name strong a").text
        projects[title.to_sym] = {
          :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
          :description => project.css("p.bbcard_blurb").text,
          :location => project.css("ul.project-meta li span").text,
          :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
        }
      end
    # return the projects hash
  projects
end

create_project_hash



#Nokogiri's css method allows us to target individual or groups of HTHML methods using CSS selectors.
#projects: kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
#image_link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta li span").text
