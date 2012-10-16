require_relative 'library'

def print_usage
  puts "USAGE:"
  puts "  ./poll.rb --name <PARTIAL NAME TO MATCH>"
  puts "  ./poll.rb --any-tags <TAG> <TAG>? ..."
  puts "  ./poll.rb --all-tags <TAG> <TAG>? ..."
end

if ARGV.length < 1
  print_usage
  exit
end

case ARGV[0]
when '--name'
  entries = githubbers_by_name(ARGV[1])
when '--any-tags'
  entries = githubbers_by_tags(ARGV[1 .. -1])
when '--all-tags'
  entries = githubbers_by_all_tags(ARGV[1 .. -1])
end

entries.each do |e|
  puts "Name:    #{e['name']}"
  puts "Tags:    #{e['tags']}"
  puts "Date:    #{e['date']}"
  puts "Image:   #{e['image']}"
  puts "Content: #{e['content']}"
  puts "----------------------------------------------------"
end
