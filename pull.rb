require 'bundler'
Bundler.require

require 'json'

tags = ["he", "him", "his", "she", "her", "father", "mother", "gal", "guy",
        "tool", "ops", "press", "media", "devops",
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

exclude = ["ordered list"]

if ARGV[0] == "--html"
  output = :html
elsif ARGV[0] == "--markdown" || ARGV[0] == "--md"
  output = :md
elsif ARGV[0] == "--flat"
  output = :flat
elsif ARGV[0] == "--json"
  output = :json
else
  puts "USAGE : (select output option)"
  puts "  ./pull.rb [--markdown | --json | --html | --flat ]"
  puts ""
  exit
end

if output == :html
  puts "<html>"
  puts "  <head>"
  puts "    <title>Githubbers</title>"
  puts "  </head>"
  puts "  <body>"
  puts "    <ul>"
elsif output == :md
  puts "# Githubbers"
  puts "### Looking for tags:"
  puts ""
  tags.sort.each do |tag|
    puts "#{tag}"
  end
  puts ""
elsif output == :json
  puts "{"
  puts "  \"tags\":       #{tags},"
  puts "  \"githubbers\": ["
end

idx = 0
10000.times do |page|
  feed = Atom::Feed.load_feed(URI.parse("https://github.com/blog.atom?page=#{page + 1}"))

  if feed.entries.count == 0
    break
  end

  feed.each_entry do |entry|
    if entry.title =~ /is a githubber/i
      # Get first image in article
      doc = Nokogiri::HTML(entry.content)
      image = doc.xpath('//img').first

      # Gather tags
      content = doc.xpath('//text()').text
      content.gsub!(/\n|\r/, " ")
      tags_found = tags.select do |tag|
        content =~ /\b#{Regexp.escape(tag)}(?:\'s|es|s)?\b/i
      end

      # Gather other data
      name = entry.title[/^(.*) is a githubber/i, 1]
      date = entry.published.to_s

      if exclude.index{|check_name| name =~ /\b#{Regexp.escape(check_name)}\b/i}
        next
      end

      if output == :html
        puts "      <li>#{name}<br />#{date}<br />Tags: #{tags_found.to_s}<br /><p>#{content}</p><br /><img src='#{image['src']}' /></li>"
      elsif output == :md
        puts "## #{name}"
        puts "#{date}"
        puts ""
        puts "### Tags:"
        tags_found.each do |tag|
          puts "* #{tag}"
        end
        puts ""
        puts "#{content}"
        puts ""
        puts "![image](#{image['src']})"
      elsif output == :json
        if idx != 0
          puts "    ,"
        end

        puts "    {"
        puts "      \"name\":    #{name.to_json},"
        puts "      \"date\":    #{date.to_json},"
        puts "      \"tags\":    #{tags_found.to_json},"
        puts "      \"content\": #{content.to_json},"
        puts "      \"image\":   #{image['src'].to_json}"
        puts "    }"
      else
        puts name
        puts date
        puts tags_found.to_s
        puts content
        puts image['src']
      end
      idx += 1
    end
  end
end

if output == :html
  puts "    </ul>"
  puts "  </body>"
  puts "</html>"
elsif output == :json
  puts "  ]"
  puts "}"
end
