@cohorts = ["january","february" ,"march","april", "may", "june", "july", "august", "september", "october", "november", "december"]
@students = []

def input_students

  puts "To finish, just hit return twice at any stage"
  name = nil
  while true do
    puts "Please enter the names of the students"
    name = gets.chomp
    puts "Enter your cohort month, e.g. January, December"
    cohort = gets.chomp.downcase
    until @cohorts.include?(cohort) do 
      if @cohorts.include?(cohort)
        break
      else
        puts "you've entered an incorrect cohort month, try again please:"
      end
    cohort = gets.chomp.downcase
    end

    puts "Please enter Hobby"
    hobby = gets.chomp
    puts "Please enter Birth Country"
    birth_country = gets.chomp
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby, birth_country: birth_country}
    @students.count == 1 ? "Now we have 1 student" : "Now we have #{@students.count} students"

    puts "Are you done adding students? y = quit, anything else carry on "
    quit = gets.chomp.downcase
    if quit == "y"
      break
    end

  end
  @students
end

def print_header  
  puts "The students of Villains Academy"
  puts "-------------".center(20)
end 

def print_names
  if @students.length == 0
    return
  end
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

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the students"
    puts "4. Load existing students"
    puts "9. Exit" 
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

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each { |line|
    name, birth_country,hobby,cohort = line.chomp.split(',')
    @students << {:name => name, cohort: cohort.to_sym,birth_country: birth_country, hobby: hobby}
    }
  file.close
end

def process(selection)
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
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu