---
  tags: scraping, nokogiri, tutorial
  languages: ruby, html, css
  resources: 2
---

# Scraping Kickstarter

## Intro

In this short tutorial, we'll be learning the basics of using the [Nokogiri](http://nokogiri.org/) gem by scraping a small portion of [Kickstarter](http://kickstarter.com/).

First, we'll learn how to make an http request using Ruby's [Open-URI](http://ruby-doc.org/stdlib-2.1.0/libdoc/open-uri/rdoc/OpenURI.html) module. Then, we'll learn how to convert that response into a `Nokogiri::HTML::Document` object, collect the data we're interested in, and store it into a data structure of our choosing.

## Assumptions

This guide assumes basic Ruby knowlege and familiarity with nested data structures. If you need a refresher on hashes and arrays, consider reviewing them on the [Codecademy](http://codecademy.com) Ruby track.

## Getting Started

The first thing we need to do is set up our project. Normally, we'd want to test drive the development of this program, but for the purposes of this guide, we'll skip that. Let's go ahead and add a file in the root of our project called `kickstarter_scraper.rb`.

To be able to use either Nokogiri or Open-URI, we're going to need to make sure we require them both at the top of our file. So on the first two lines of `kickstarter_scraper.rb`, add the following:

```ruby
require 'nokogiri'
require 'open-uri'
```

(If you haven't already done so, now would be the time to make sure you install Nokogiri by running `gem install nokogiri` from your command line.)

### What is Open-URI?

Open-URI is a module in Ruby that allows us to programatically make http requests. It gives us a bunch of useful methods to make different types of requests, but for this guide, we're interested in only one: `open`. This method takes one argument, a url, and will return to us the HTML content of that url.

In other words, running:

```ruby
html = open('http://www.google.com')
```

stores the HTML of Google into a variable called html. (More specifically, it actually stores the HTML in a temporaray file that we can then call `read` on to get the raw HTML. We won't worry about that here though.)

### And Nokogiri? What's that?

From the [Nokogiri](http://nokogiri.org/) website:

> Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri’s many features is the ability to search documents via XPath or CSS3 selectors.

Essentially, Nokogiri allows us to treat a huge string of HTML as if it were a bunch of nested nodes. This means that we can access any element on a given page via handy dot-notation. We can do all of this without any ugly regular expressions, all via CSS selectors. It's amazing!

## First Steps

The best way to play around with unfamilar modules and gems is to, well, play around with them! Let's jump into IRB (type `irb` from your command line) and see if we can figure out how they work.

Once you open IRB, type `require 'open-uri'`, press Return, and then type `require 'nokogiri'` followed by another Return. Just like we did at the top of our `kickstarter_scraper.rb` file, we need to load both the Open-URI module and the Nokogiri gem into our environment.

After each of those lines, IRB should respond with:

```ruby
=> true
```

If it doesn't, check to make sure that your environment is set up properly and that Nokogiri is indeed installed on your system.

Let's start with Open-URI. Create a variable, `html`, and set it equal to the following line of code:

```ruby
html = open('http://google.com')
```

You should see some output similar to this:

```
#<File:/var/folders/j8/141_clfx1cz88f86y8ggfd2c0000gn/T/open-uri20140210-1226-9l2b5d>
-rw-------  1 loganhasson  staff  11072 Feb 10 19:38 /var/folders/j8/141_clfx1cz88f86y8ggfd2c0000gn/T/open-uri20140210-1226-9l2b5d
```

The formatting may be different in your case. But what has happened is that Open-URI has made an http request to `http://google.com` and stored the response in a temporary file.

To see what that HTML looks like, we can call the `read` method on that file. Since we've stored it in the `html` variable, we can see the raw HTML like this:

```
html.read
```

You'll get a huge amout of ugly HTML, the top of which will look something like:

```
"<!doctype html><html itemscope=\"\" itemtype=\"http://schema.org/WebPage\"><head><meta content=\"Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for.\" name=\"description\">...
```

Gross. Can you imagine if we needed to parse through that manually? Just thinking about the regular expressions involved makes my head hurt.

Nokogiri to the rescue!

Don't worry about this syntax too much now, but the Nokogiri gem gives us this cool method, `Nokogiri::HTML` that takes an HTML string and converts it into this giant NodeSet (aka, a bunch of nested "nodes") that we can easily play around with.

Let's use that `html` variable again and pass it to the `Nokogiri::HTML` method and see what happens:

```
nokogiri_doc = Nokogiri::HTML(html)
```

You should see a bunch of output, the top of which looks something like:

```
#<Nokogiri::HTML::Document:0x811468ac name="document" children=[#<Nokogiri::XML::DTD:0x8114635c name="html">, #<Nokogiri::XML::Element:0x811460f0 name="html" attributes=[#<Nokogiri::XML::Attr:0x8114608c name="itemscope">...
```

If you don't see that output (and instead something really short), it may be because that temporary file from earlier got deleted. Just run `html = open('http://google.com')` again, followed by `nokogiri_doc = Nokogiri::HTML(html)` and you should be fine.

This returns to us a giant object that consists of nested "nodes" that we can drill down into using CSS selectors. Let's see if we can do something useful with it.

In your browser, visit `http://google.com`. Let's see if we can use this Nokogiri object to store the text from one of the buttons (say, the search button) into a variable. Not terribly exciting, but useful to demonstrate how Nokogiri gets stuff done.

Hopefully you're using Chrome. If you are, right click on the 'Google Search' button, and select 'Inspect Element'. You should see something like:

```html
<span id="gbqfsa">Google Search</span>
```

What this tells us is that the button text is within a `<span>` that has an id of 'gbqfsa', which is totally not confusing at all...-_-

Anyway, we can use this knowledge to drill through the Nokogiri object and select just that text.

### Pause

Ok, so Google's HTML is actually super annoying, and apparently from one request to the next, ids change. So, let's back up for a second and try this out with the Taco Bell's website.

1. `tacobell_html = open('http://www.tacobell.com')`
2. `tacobell_doc = Nokogiri::HTML(tacobell_html)`
3. Open `http://www.tacobell.com` in your browser, right click on the logo in the upper left-hand corner of the page.

Phew. You should now see something like:

```html
<a href="/" style="background-image:url('/static_files/TacoBell/StaticAssets/images/reskin/bnr_lgo_main_02.png');">Taco Bell</a>
```

Ok. Let's say now that we want to store the CSS for that background-image into a variable. It's not so useful, but hey, why not? Again, Nokogiri to the rescue!

Now, as I mentioned before, Nokogiri works by CSS selectors. To figure out where this logo actually lives, we're going to have to look at its parent element to see if there are any unique classes or ids we can use:

In this case, Taco Bell made it super easy for us. The parent element is an `div` with an `id` of `headerLogo`:

```html
<div id="headerLogo">
```

Now's the time for the oh-wow-mind-blown part of this. If we want to get that "style" attribute that is the background-image? The first thing we need to do is select the parent div:

```
tacobell_doc.css("div#headerLogo")
```

We do this by calling the `css` method on our Nokogiri object. This method takes an argument, which is a CSS selector.

But, that selector isn't quite specific enough. If you notice, the thing we actually want is within an `a` tag inside of the `headerLogo` div. Just like we would do in a CSS stylesheet, we just add that `a` on to the end of our selector.

```
tacobell_doc.css("div#headerLogo a")
```

Hit return and you should get the following:

```
[#<Nokogiri::XML::Element:0x811ffdac name="a" attributes=[#<Nokogiri::XML::Attr:0x811ffd34 name="href" value="/">, #<Nokogiri::XML::Attr:0x811ffd20 name="style" value="background-image:url('/static_files/TacoBell/StaticAssets/images/reskin/bnr_lgo_main_02.png');">] children=[#<Nokogiri::XML::Text:0x811ff4d8 "Taco Bell">]>]
```

Now, we're almost there, but this doesn't quite do it yet. If you notice, this is actually a nested structure. Inside of it, we have something called "attributes". Let's drill into that to get at the "style" that we are interested in:

```
tacobell_doc.css("div#headerLogo a").attribute("style")
```

It's as easy as adding on a call to the `attribute` method which, you guessed it, takes an attribute as an argument.

Hit return, and you get:

```
#<Nokogiri::XML::Attr:0x811ffd20 name="style" value="background-image:url('/static_files/TacoBell/StaticAssets/images/reskin/bnr_lgo_main_02.png');">
```

So close! We just need to strip out everything except for the value, which we do by adding on a call to the `value` method. Easy, right?

```
tacobell_doc.css("div#headerLogo a").attribute("style").value
=> "background-image:url('/static_files/TacoBell/StaticAssets/images/reskin/bnr_lgo_main_02.png');"
```

Nice! Parsing and scraping a website follows this pattern over and over again. You just need to play around with the Nokogiri representation of whatever site you want to scrape, and then access the data using the correct combitiation of selectors and method calls.

Now, let's jump into our project.

## Actually Scraping Kickstarter

Visit the following link in your browser: `https://www.kickstarter.com/discover/places/new-york-ny?ref=city`

Your version of that link may vary, so instead of describing exact data, let's talk about a structure we'd like to programatically get the data on that page into.

The page, without clicking on "More", displays 20 previews of projects in the NYC area. Each card seems to have a title, an image, a mini description, a location, and some funding details. For our purposes, let's say we want to collect the following data in a hash for each project:

```ruby
:project => {
  :title => "Title",
  :image_link => "Image Link",
  :description => "Description",
  :location => "Location",
  :percent_funded => "Percent Funded"
}
```

This will probably be in a larger hash called `projects`. Sound good?

### Some Considerations

Since the data on Kickstarter will change from minute to minute, this project contains a file, `fixtures/kickstarter.html` that we'll be using instead of making an Open-URI request. All that file contains is the data we would have gotten back from Open-URI at a specific time. This way, we can all work from the same version of the data.

### Setting Up Our Project

Since we'll be using that `kickstarter.html` file instead of an Open-URI request, we can actually remove the `require 'open-uri'` line from `kickstarter_scraper.rb`. Next, let's set up some variables:

```ruby
# This just opens a file and reads it into a variable
html = File.read('fixtures/kickstarter.html')

kickstarter = Nokogiri::HTML(html)
```

Notice that this is pretty similar to what we did above.

### Selecting the Projects

The first thing we'll want to do is figure out what selector well allow us to grab each project "preview" as a whole. From your terminal, open up `fixtures/kickstarter.html` by typing:

```bash
open fixtures/kickstarter.html
```

This should open it in Chrome. Right click somewhere on the "Moby Dick" project and choose "Inspect Element". By moving your mouse up and down in the HTML in the inspector, you can see what each element represents what on the page via some cool highlighting. By moving your mouse around, it quickly becomes clear that each project is contained in:

```html
<li class="project grid_4">...</li>
```

This is awesome. Since this Nokogiri object is just a bunch of nested nodes, and we know how to iterate through a nested data structure, we can use the Ruby we already know to iterate through each of these projects and do stuff with them.

Just to check our assumptions, let's add a `require 'pry'` at the top of our file, and add `binding.pry` after the last line. Then type `ruby kickstarter_scraper.rb` into your terminal. This should drop us into pry, so that we can play around.

In pry, type in:

```
kickstarter.css("li.project.grid_4").first
```

This will select the first `li` with the `project` and `grid_4` classes just so that we can make sure we've chosen our selector's correctly.

And we have! (If you don't see any output, or see an empty array, make sure you've typed everything exactly as it was typed here.)

Awesome! Let's add a comment to `kickstarter_scraper.rb` that reminds us of that selector:

```ruby
# projects: kickstarter.css("li.project.grid_4")
```

### Selecting the Title

Let's hop back into pry and see if we can figure out how to get the title of that project.

In pry, type:

```
project = _
```

This will assign that project to a variable, `project` so that we can play around with it.

Looking back in the inspector in Chrome, and clicking around a bit, it seems like the title is in an `h2` with a class of `bbcard_name`, inside a `strong` and then an `a` tag. Let's check that in pry:

```
project.css("h2.bbcard_name strong a").text
```

Since Nokogiri gives us a bunch of nested nodes that all respond to the same methods, we can just chain a `css` method right onto this `project`. Neat, huh?

Cool, let's add that selector into a comment in our `kickstarter_scraper.rb`.

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
```

### Selecting the Image Link

What's next? Oh yeah, the Image URL. This one should be easy. Back in Chrome, we can see in the inspector that there is a `div` with a class of `project-thumbnail`. Seems like a good place to look, no?

In pry, type:

```
project.css("div.project-thumbnail a img").attribute("src").value
```

Boom! Isn't it awesome how we can just chain a bunch of stuff that we used earlier to drill down as far as we want?

Now, let's keep track of that in our project file:

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
```

### Selecting the Description

Are you starting to see a pattern here? We click around a bit in the Chrome web inspector, take a stab at a CSS selector in pry, and then keep track of that selector in our project file. Let's grab the description now. In pry:

```
project.css("p.bbcard_blurb").text
```

Is that what you got?

Let's add that to `kickstarter_scraper.rb`:

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
```

### Selecting the Location

Do you think you can figure this one out on your own? Play around in pry, and then come back here when your done. (I'll add this as a comment in the next section just in case you can't figure it out right away.)

### Selecting the Percent Funded

And last, but not least, let's try and grab the percent funded as well! Looking in Chrome, it seems that this one is just a bit trickier, but only because it's a bit more nested than the other ones. In pry, type:

```
project.css("ul.project-stats li.first.funded strong").text
```

That does it! To make it useful for later on if, say, we wanted to do some math, let's also tag on a `.gsub("%", "").to_i` to remove the percent sign and convert it into an integer.

Our final list of comments in our `kickstarter_scraper.rb` file, then (including the location from above), is:

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
```

### Let's Scrape!

Now, it's just a matter of putting together the data we can grab with Nokogiri with our knowledge of data iteration in Ruby.

First, let's set up a loop to iterate through the projects (and also an empty `projects` hash, which we haven't done yet):

```ruby
# file: kickstarter_scraper.rb

require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

html = File.read('fixtures/kickstarter.html')
kickstarter = Nokogiri::HTML(html)

projects = {}

# Iterate through the projects
kickstarter.css("li.project.grid_4").each do |project|
  projects[project] = {}
end
```

Ok, so that won't work, actually. That's going to make some really wacky key which is a huge Nokogiri object. So, let's change our data structure slightly and make it so that each project title is a key, and the value is another hash with each of our other data points as keys. Sound good?

```ruby
# file: kickstarter_scraper.rb

...

projects = {}

kickstarter.css("li.project.grid_4").each do |project|
  title = project.css("h2.bbcard_name strong a").text.to_sym
  projects[title] = {}
end
```

That's better. You'll notice that I'm also converting the title into a symbol using the `to_sym` method. It's not required, but it's better on memory.

Finally, it's just a matter of grabbing each of the data points using the selectors we've already figured out, and adding them to each project's hash. So, our complete code will look something like this:

```ruby
# file: kickstarter_scraper.rb

require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

html = File.read('fixtures/kickstarter.html')
kickstarter = Nokogiri::HTML(html)

projects = {}

kickstarter.css("li.project.grid_4").each do |project|
  title = project.css("h2.bbcard_name strong a").text.to_sym
  projects[title] = {
    :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
    :description => project.css("p.bbcard_blurb").text,
    :location => project.css("ul.project-meta span.location-name").text,
    :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  }
end
```
## Resources
* [Codecademy](http://www.codecademy.com/dashboard) - [Ruby Track: Data Structures](http://www.codecademy.com/courses/ruby-beginner-en-F3loB/0/1), page 
* [RailsCasts](http://railscasts.com/) - [#190 Screen Scraping with Nokogiri](http://railscasts.com/episodes/190-screen-scraping-with-nokogiri)
