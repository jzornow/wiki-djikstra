require './lib/djikstra/runner'
require './lib/wikipedia/gateway'

runner = Djikstra::Runner.new Wikipedia::Gateway.new

puts "Enter Initial Search Term:"
start_term = gets.chomp

puts "\nEnter the Search Term that you would like to reach:"
end_term = gets.chomp

puts "\nBeginning search... HOLD ON!"
result = runner.find(
  start_page: start_term,
  end_page: end_term
)

puts "\n#{'=' * 100}"
puts result
puts "  Pages Visited: #{runner.visited_paths.count}"
puts "  Links Collected: #{runner.unvisited_paths.count}"
puts '=' * 100
