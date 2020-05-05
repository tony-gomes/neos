require './lib/neo_data_table'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp
neo_table = NeoDataTable.new(date)

puts "______________________________________________________________________________"
puts "On #{neo_table.formatted_date}, there were #{neo_table.total_number_of_asteroids} objects that almost collided with the earth."
puts "The largest of these was #{neo_table.largest_asteroid} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts neo_table.table_divider
puts neo_table.table_header
neo_table.create_rows(neo_table.asteroid_list, neo_table.column_data)
puts neo_table.table_divider
