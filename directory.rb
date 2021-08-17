
def input_students
  puts "To finish, just hit return twice at any stage"

  
  students = []
  name = nil
  while name != "" do
    puts "Please enter the names of the students"
    name = gets.chomp

    puts "Please enter Hobby"
    hobby = gets.chomp

    puts "Please enter Birth Country"
    birth_country = gets.chomp

    students << {name: name, cohort: :november, hobby: hobby, birth_country: birth_country}
    puts "Now we have #{students.count} students"

  end
  students
end

def print_header  
  puts "The students of Villains Academy"
  puts "-------------".center(20)
end 

def print_names(students, first_letter)
# {:name=>"ed", :cohort=>:november}

  acc = 0
  while acc < students.length do
    if students[acc][:name][0] == first_letter && students[acc][:name].length < 12
       puts "#{acc + 1}. #{students[acc][:name]} (#{students[acc][:cohort]} cohort)"
    end
    acc += 1
  end
  


  # students.each_with_index do |student, index|
  #    if student[:name][0] == first_letter && student[:name].length < 12
  #     puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
  #   end
  # end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print_names(students, "e")
print_footer(students)
