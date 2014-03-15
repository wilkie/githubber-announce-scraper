# EXAMPLE USAGE OF JSON READER
#
# This is an example of using the json library to do some analytics

require_relative 'library'

puts "# Gender-tagging GitHub Hire Announcements"

tags = ["he", "him", "his", "she", "her", "father", "mother", "gal", "guy",
        "tool", "ops", "press", "media", "devops", "windows",
        "code", "infrastructure", "database", "developer", "designer", "ux",
        "ui", "web", "marketing", "seo", "business", "financial", "rails",
        "operation", "shop", "git", "scm", "scms", "cocoa", "ios", "ruby",
        "software", "cooking", "enterprise", "support", "administration",
        "javascript", "supportocat", "community", "linux",
        "accounting", "creative", "objective-c", "programming", "data mining",
        "data miner", "training", "api", "rspec", "testing", "test",
        "contributor", "contribute", "contribution", "sales",
        "java", "c", "interface", "iphone app", "node.js",
        "node", "sysadmin", "administration", "administrator",
        "font", "fonts", "illustrator", "usability", "system", "deployment",
        "scaling", "server", "css", "design",
        "reliability", "reliable", "open source", "manager", "blog", "writing",
        "organization", "organizing", "coordination", "coordinating",
        "android"]

dev_tags = ["tool", "ops", "devops",
            "code", "infrastructure", "database", "developer", "ux",
            "ui", "web", "rails",
            "git", "scm", "scms", "cocoa", "ios", "ruby",
            "software", "javascript", "linux",
            "objective-c", "programming",
            "api", "rspec", "testing", "test",
            "contributor", "contribute", "contribution",
            "java", "c", "interface", "iphone app", "node.js",
            "node",
            "system", "deployment",
            "scaling", "server",
            "reliability", "reliable", "open source",
            "android"]

def pronouns_women
  ["she", "her", "mother", "gal"]
end

def pronouns_men
  ["he", "his", "him", "father", "guy"]
end

puts "## Description of tags"

puts "### All tags"
puts "```"
puts tags.join(" ")
puts "```"
puts "### Tags that identify developers"
puts "```"
puts dev_tags.join(" ")
puts "```"
puts "### Tagging 'woman' when we seen one of the following:"
puts "```"
puts pronouns_women.join(" ")
puts "```"
puts "### In higher number than the following tags for 'man':"
puts "```"
puts pronouns_men.join(" ")
puts "```"

def female_githubbers
  githubbers_by_tags(pronouns_women)
end

def male_githubbers
  githubbers_by_tags(pronouns_men)
end

women = female_githubbers
women = women.select do |gh|
  # ensure there are more female pronouns than male
  num_pronouns_women = gh['tags'].select{|t| pronouns_women.include?(t) }.length
  num_pronouns_men   = gh['tags'].select{|t| pronouns_men.include?(t)   }.length

  num_pronouns_women > num_pronouns_men
end

men = male_githubbers
men = men.select do |gh|
  # ensure there are more male pronouns than female
  num_pronouns_women = gh['tags'].select{|t| pronouns_women.include?(t) }.length
  num_pronouns_men   = gh['tags'].select{|t| pronouns_men.include?(t)   }.length

  num_pronouns_women < num_pronouns_men
end

women.map! do |w|
  "* [#{w['name']}](#{w['url']}):#{w['tags'].index { |t| dev_tags.include?(t) } ? " **developer?**" : ""} #{w['tags']}"
end

men.map! do |m|
  "* [#{m['name']}](#{m['url']}):#{m['tags'].index { |t| dev_tags.include?(t) } ? " **developer?**" : ""} #{m['tags']}"
end

puts "## Tagged as 'women':"
puts women
puts ""
puts "## Tagged as 'men':"
puts men
