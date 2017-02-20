##### CLASSES ######

# these are the gem files required for the table and paint
require 'paint'
require 'terminal-table'

# lets the user customise progress bar
class ProgressBar
  def initialize(title, increment, size)
    @title = title
    @increment = increment
    @size = size
  end

  attr_accessor :title, :increment, :size

end

# Lets the user customise questions to ask and if there are any specials to add
# to questions such as days of week, time, date, whatever, etc
class Questioner
  def initialize(specials, questions)
    @specials = specials
    @questions = questions
  end

  attr_accessor :questions, :specials

  # This asks questions and takes answers into an array
  def print_questions(special, questions, title, increment, size)

      answers = Array.new

      counter = 0

      # loops through each element of array to display
      # questions with special and stores user answers in array
      @specials.each do |special|

        counter += increment
        puts "#{title} (#{counter}/ #{size})"

        print questions + special
        puts "?"
        answer = gets.chomp.to_i

        answers << answer

        system 'clear'

      end

      return answers
  end
end

#### METHODS ####

# Convert from C to F
def convert_CtoF (answers)

  fahrenheit = Array.new

  # This colours the numbers based on the size the number
  answers.each do |answer|
    if answer > 30
      f_answer = Paint[((answer * 9.0) / 5.0) + 32, :red]
    elsif answer > 10
      f_answer = Paint[((answer * 9.0) / 5.0) + 32, :green]
    elsif answer > 0
      f_answer = Paint[((answer * 9.0) / 5.0) + 32, :blue]
    end

    fahrenheit.push f_answer

  end

  return fahrenheit
end

# Creates the table
def table (table)

  table1 = Terminal::Table.new :title => "John's Temperature Chart", :headings => ['Day', 'Celsius', 'Fahrenheit'], :rows => table

end

# Joins the different arrays into one multi-dimensional array
def join_arrays(new_arr, arr1, column, size)

  row = 0
  while row != size

    new_arr[row][column] = arr1[row]

    row += 1
  end

  return new_arr

end

# This colours the celsius values
def c_colour(celsiuses)

  c_celsiuses = Array.new

  celsiuses.each do |celsius|
    if celsius > 30
      c_celsius = Paint[celsius, :red]
    elsif celsius > 10
      c_celsius = Paint[celsius, :green]
    elsif celsius > 0
      c_celsius = Paint[celsius, :blue]
    end

    c_celsiuses << c_celsius

  end

  return c_celsiuses
end


##### MAIN #####

# Variable for progress bar and print
count_days = ProgressBar.new("Current day: ", 1, 7)

# Special formats for questions, new question object, and call to print questions
days_of_week = [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
question = "What was the temperature on "
what_temp = Questioner.new(days_of_week, question)

# This sends the progress_bar deets and Questioner deets to the print method
# in the Questioner class
celsius = what_temp.print_questions(what_temp, what_temp.questions, count_days.title, count_days.increment, count_days.size)

# This converts the celsius to fahrenheit and puts it in array
fahrenheit = convert_CtoF(celsius)

# Creates new array to colour the celsius numbers
celsius = c_colour(celsius)

# This creates a new 2D array to store the previous 3 arrays
new_arr = Array.new(7) { Array.new(3) }

# This calls functions to put different arrays into one
# NOT A GREAT SOLUTTON!!
joint_arr = join_arrays(new_arr, days_of_week, 0, 7)

joint_arr = join_arrays(joint_arr, celsius, 1, 7)

joint_arr = join_arrays(joint_arr, fahrenheit, 2, 7)

# Prints table
puts table(joint_arr)


=begin


=end
