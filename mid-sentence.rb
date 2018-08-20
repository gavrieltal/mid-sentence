require 'io/console'
require "linkparser"


dict = LinkParser::Dictionary.new(
  {max_null_count: 0}
)

shell_string = "linkparser> "
user_string  = ""
num_linkages_to_show = 4

puts "type Esc to exit program."


loop do
  print shell_string, user_string
  
  c = STDIN.getch

  if c == "\u007F"
    user_string = user_string[0...-1]
  elsif c == "\e"
    puts "\nExiting program..."
    exit
  else
    user_string = user_string + c
  end
  
  if !user_string.empty?    
    parse = dict.parse(user_string)    
    if parse.num_linkages_found.positive?
      print "\n" + "*" * 70 + "\n"      
      reversed = parse.linkages.reverse
      reversed[0...num_linkages_to_show].each do |link|
        print link.diagram(max_width: 200)
      end      
      print "#{parse.num_linkages_found} linkages found. "
      print "Best #{[num_linkages_to_show, parse.num_linkages_found].min} "
      print "shown in reverse, with the best matches on bottom."
    end    
  end
  
  print "\n"
end
