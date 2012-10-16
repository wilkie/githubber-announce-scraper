# Reads githubber json files
# 
# contains useful query functions

require 'json'

@@json = JSON.parse(File.open('output.json').read)

def tags
  @@json['tags']
end

def githubbers
  @@json['githubbers']
end

def githubbers_by_name(name)
  githubbers.select do |gh|
    gh['name'] =~ /#{Regexp.escape(name)}/i
  end
end

def githubbers_by_tag(tag)
  githubbers.select do |gh|
    gh['tags'].include? tag
  end
end

def githubbers_by_tags(tags)
  githubbers.select do |gh|
    gh['tags'].index do |t|
      tags.include? t
    end
  end
end

def githubbers_by_all_tags(tags)
  githubbers.select do |gh|
    tags.inject(true) do |acc, t|
      acc && gh['tags'].include?(t)
    end
  end
end
