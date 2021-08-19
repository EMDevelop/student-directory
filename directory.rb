@cohorts = ["january","february" ,"march","april", "may", "june", "july", "august", "september", "october", "november", "december"]
@students = []

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
    @students.count == 1 ? "Now we have 1 student" : "Now we have #{@students.count} students"
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

def menu_options
  {
    1=> "Input the students",
    2=> "Show the students",
    3=> "Save the students",
    4=> "Load existing students",
    9=> "Exit" 
  }
end

def print_menu
  menu_options.each { |number, description|
    puts "#{number}. #{description}"
  }
end

def show_students
  print_header
  print_names
  print_footer
end

def save_students
  #Saves to CSV
  file = File.open("students.csv", "w")
  @students.each do |student|
    data = [student[:name],student[:birth_country], student[:hobby],student[:cohort]]
    line = data.join(",")
    file.puts line
  end
  file.close
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
  file = File.open(file_name, "r")
  file.readlines.each { |line|
    name, birth_country,hobby,cohort = line.chomp.split(',')
    update_student_records(name, cohort.to_sym, hobby, birth_country)
    }
  file.close
end

def process(selection)
  puts "you chose #{print_menu[selection.to_i]}"
  case selection
    when "1"
      input_students   
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit 
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  ARGV.first.nil? ? load_students : check_valid_file
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end



interactive_menu