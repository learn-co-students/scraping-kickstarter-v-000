# require libraries/modules here
require "nokogiri"
require "pry" #used for stopinng code in dev and see what goes
#in this lab we are not using the below requirement because the html information is not coming from a live website, but from a local files
#require "open-uri"


def create_project_hash
          # This just opens a local file and reads it into a variable
      html = File.read('fixtures/kickstarter.html')
          #if the file was on the internert, the code would look like below
          #html = open("http://kickstarter.com")
          # lets assign a variable with the action of reading the local html file with nokogiri
      kickstarter = Nokogiri::HTML(html)
      projects={}

      kickstarter.css("li.project.grid_4").each do |project|
        title = project.css("h2.bbcard_name strong a").text
        #lets setup hashes
        projects[title.to_sym] = {
                                  :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
                                  :description => project.css("p.bbcard_blurb").text,
                                  :location => project.css("ul.project-meta span.location-name").text,
                                  :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
                                  }
        #You'll notice above that we're converting the title into a symbol using the to_sym method. Remember that symbols make better hash keys than strings.
      end

           # return the projects hash
           projects
      #binding.pry #lets stope the code here when running so we can see whats going on

end

create_project_hash

#kickstarter.css("li.project.grid_4").first
#This will select the first li with the project and grid_4 classes just so that we can make sure we've chosen our selectors correctly.

#projects:    kickstarter.css("li.project.grid_4")
#title:       project.css("h2.bbcard_name strong a").text
#image link:  project.css("div.project-thumbnail a img").attribute("src").value
            #for above attribute method, see below in tips
#description: project.css("p.bbcard_blurb").text
#location:    project.css("ul.project-meta span.location-name").text
#%funded:     project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i






#Tips
#Top-Tip: The variable_name = _ syntax used in Pry will assign the variable name to the return value of whatever was executed above. For example:
#A note ON .ATTRIBUTE An image tag in HTML is considered to have a source attribute. In the following example <img src="http://www.example.com/pic.jpg"> the source attribute would be "http://www.example.com/pic.jpg". You can use the .attribute method on a Nokogiri element to grab the value of that attribute.
