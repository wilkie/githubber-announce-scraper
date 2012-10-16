# EXAMPLE USAGE OF JSON READER
#
# This is an example of using the json library to do some analytics

require_relative 'library'

dev_tags = ["tool", "ops", "devops",
            "code", "infrastructure", "database", "developer", "ux",
            "ui", "web", "rails",
            "operation", "git", "scm", "scms", "cocoa", "ios", "ruby",
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

def female_githubbers
  githubbers_by_tags(["she", "her", "mother", "gal"])
end

def male_githubbers
  githubbers_by_tags(["he", "his", "him", "father", "guy"])
end

women = female_githubbers
women = women.select do |gh|
  gh['tags'].index do |t|
    dev_tags.include? t
  end
end

women.map! do |w|
  "#{w['name']}: #{w['tags']}"
end

puts women
