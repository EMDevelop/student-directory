require 'csv'
@cohorts = ["january","february" ,"march","april", "may", "june", "july", "august", "september", "october", "november", "december"]
@students = []
@file

def input_students
  puts "To finish, just hit return twice at any stage"
  while true do
    puts "Please enter the names of the students"
    name = STDIN.gets.chomp
    puts "Enter your cohort month, e.g. January, December"
    cohort = check_valid_cohort(STDIN.gets.chomp.downcase)
    puts "Please enter Hobby"
    hobby = STDIN.gets.chomp
    puts "Please enter Birth Country"
    birth_country = STDIN.gets.chomp
    update_student_records(name, cohort.to_sym, hobby, birth_country)
    break if finished_input
  end
end

def finished_input
  puts "type 'quit' to quit, hit 'enter' to add more"
  input = STDIN.gets.chomp.downcase
  input == "quit" ? true : false 
end

def check_valid_cohort(input)
  return input if @cohorts.include?(input) 

  while true do
    puts "you've entered an incorrect cohort month, try again please:"
    cohort = STDIN.gets.chomp.downcase
    return cohort if @cohorts.include?(cohort) 
  end

end

def update_student_records(name, cohort, hobby, country)
  @students << {name: name, cohort: cohort, hobby: hobby, birth_country: country}
  @students.count == 1 ? "Now we have 1 student" : "Now we have #{@students.count} students"
end

def print_header  
  puts "The students of Villains Academy"
  puts "-------------".center(20)
end 

def print_names
  return if @students.length == 0
  acc = 0
  while acc < @cohorts.length do
    puts "Students enrolled in our #{@cohorts[acc].capitalize!} cohort:"
    @students.map { |student|
      if student[:cohort] == @cohorts[acc].downcase.to_sym
        puts student[:name]
      end
    }
    acc += 1
  end

end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end


def show_students
  print_header
  print_names
  print_footer
end

def save_students(file_name = "students.csv")
  #Saves to CSV
  File.open(file_name, "w") {|file|
    @students.each do |student|
      data = [student[:name],student[:birth_country], student[:hobby],student[:cohort]]
      line = data.join(",")
      file.puts line
    end
  }
end


def check_valid_file
  filename = ARGV.first
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

def load_students(file_name = "students.csv")
  # File.open(file_name, "r") { |file|
  # file.readlines.each { |line|
  #   name, birth_country,hobby,cohort = line.chomp.split(',')
  #   update_student_records(name, cohort.to_sym, hobby, birth_country)
  #   }
  # }
  # refactor to use CSV class
  CSV.foreach("./students.csv") do |row|
    # puts row.length
    update_student_records(row[0], row[3].to_sym, row[2], row[1])
  end
end



def menu_options
  { #ref https://stackoverflow.com/questions/13033830/ruby-function-as-value-of-hash
    1=> {"option_name" =>  "Input the students", "method" => method(:input_students)},
    2=> {"option_name" => "Show the students","method" => method(:show_students)},
    3=> {"option_name" => "Save the students","method" => method(:save_students)},
    4=> {"option_name" => "Load existing students","method" => method(:load_students)},
    9=> {"option_name" => "Exit", "method" => "exit"},
  }
end

def print_menu
  menu_options.each { |number, description|
    puts "#{number}. #{description["option_name"]}"
  }
end

def process_selection(selection)
  puts "you chose #{print_menu[selection.to_i]["option_name"]}"
  if !menu_options[selection]
    puts "I don't know what you meant, try again" 
  elsif menu_options[selection]["method"] == "exit"
    exit
  else
    menu_options[selection]["method"].call
  end
end

def interactive_menu
  ARGV.first.nil? ? load_students : check_valid_file
  loop do
    print_menu
    process_selection(STDIN.gets.chomp.to_i)
  end
end



interactive_menu