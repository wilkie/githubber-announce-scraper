# EXAMPLE USAGE OF JSON READER
#
# This is an example of using the json library to do some analytics

require_relative 'library'

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

def female_githubbers
  githubbers_by_tags(pronouns_women)
end

def male_githubbers
  githubbers_by_tags(pronouns_men)
end

women = female_githubbers
women = women.select do |gh|
  index = gh['tags'].index do |t|
    dev_tags.include? t
  end

  # ensure there are more female pronouns than male
  num_pronouns_women = gh['tags'].select{|t| pronouns_women.include?(t) }.length
  num_pronouns_men   = gh['tags'].select{|t| pronouns_men.include?(t)   }.length

  index && num_pronouns_women > num_pronouns_men
end

men = male_githubbers
men = men.select do |gh|
  index = gh['tags'].index do |t|
    dev_tags.include? t
  end

  # ensure there are more male pronouns than female
  num_pronouns_women = gh['tags'].select{|t| pronouns_women.include?(t) }.length
  num_pronouns_men   = gh['tags'].select{|t| pronouns_men.include?(t)   }.length

  index && num_pronouns_women < num_pronouns_men
end

women.map! do |w|
  "#{w['name']}: #{w['tags']}"
end

men.map! do |w|
  "#{w['name']}: #{w['tags']}"
end

puts women
puts "-=-=-=-=-=-"
puts men
