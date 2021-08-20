def read_myself 
  myself = File.open("./readmyself.rb", "r")
  myself.each_line {|line|
    print "#{line}\n"
  }
end

read_myself