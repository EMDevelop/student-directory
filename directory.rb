cohorts = ["january","february" ,"march","april", "may", "june", "july", "august", "september", "october", "november", "december"]

def input_students(cohorts)

  puts "To finish, just hit return twice at any stage"
  students = []
  
  name = nil
  
  while true do
    
    puts "Please enter the names of the students"
    name = gets.chomp

    puts "Enter your cohort month, e.g. January, December"
    cohort = gets.chomp.downcase
    until cohorts.include?(cohort) do 
      if cohorts.include?(cohort)
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

    students << {name: name, cohort: cohort.to_sym, hobby: hobby, birth_country: birth_country}
    students.count == 1 ? "Now we have 1 student" : "Now we have #{students.count} students"
    print students
    
    puts "Are you done adding students? y = quit, anything else carry on "
    quit = gets.chomp.downcase
    if quit == "y"
      break
    end

  end
  students
end

def print_header  
  puts "The students of Villains Academy"
  puts "-------------".center(20)
end 

def print_names(students,cohorts)
  acc = 0
  while acc < cohorts.length do
    puts "Students enrolled in our #{cohorts[acc].capitalize!} cohort:"
    students.map { |student|
      if student[:cohort] == cohorts[acc].downcase.to_sym
        puts student[:name]
      end
    }
    acc += 1
  end

end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# students = input_students(cohorts)
# print_header
# print_names(students, cohorts)
# print_footer(students)

def print_a_line_break_3_times(string)
  3.times { puts string.+("\n")} 

end

print_a_line_break_3_times("hey")