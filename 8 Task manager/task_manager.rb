require 'json'
require 'date'

class TaskManager
  attr_reader :tasks

  def initialize(file = 'tasks.json')
    @file = file
    @tasks = load_tasks
  end

  # Додати нову задачу
  def add_task(title, deadline)
    id = @tasks.empty? ? 1 : @tasks.max_by { |t| t[:id] }[:id] + 1
    @tasks << { id: id, title: title, deadline: Date.parse(deadline), completed: false }
    save_tasks
  end

  # Видалити задачу
  def delete_task(id)
    @tasks.reject! { |task| task[:id] == id }
    save_tasks
  end

  # Редагувати задачу
  def edit_task(id, title: nil, deadline: nil, completed: nil)
    task = @tasks.find { |t| t[:id] == id }
    return unless task

    task[:title] = title if title
    task[:deadline] = Date.parse(deadline) if deadline
    task[:completed] = completed unless completed.nil?
    save_tasks
  end

  # Фільтрувати задачі за статусом
  def filter_by_status(completed)
    @tasks.select { |task| task[:completed] == completed }
  end

  # Фільтрувати задачі за дедлайном
  def filter_by_deadline(before_date)
    @tasks.select { |task| task[:deadline] <= Date.parse(before_date) }
  end

  private

  # Завантажити задачі з файлу
  def load_tasks
    return [] unless File.exist?(@file)

    JSON.parse(File.read(@file), symbolize_names: true).map do |task|
      task[:deadline] = Date.parse(task[:deadline]) # Перетворити строки на об'єкти Date
      task
    end
  end

  # Зберегти задачі у файл
  def save_tasks
    File.write(@file, JSON.pretty_generate(@tasks))
  end
end

# Інтерфейс консольного застосунку
if __FILE__ == $PROGRAM_NAME
  manager = TaskManager.new

  loop do
    puts "\nTask Manager:"
    puts "1. Add Task"
    puts "2. Delete Task"
    puts "3. Edit Task"
    puts "4. View Tasks"
    puts "5. Filter Tasks by Status"
    puts "6. Filter Tasks by Deadline"
    puts "7. Exit"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter task title: "
      title = gets.chomp
      print "Enter task deadline (YYYY-MM-DD): "
      deadline = gets.chomp
      manager.add_task(title, deadline)
      puts "Task added successfully!"

    when 2
      print "Enter task ID to delete: "
      id = gets.chomp.to_i
      manager.delete_task(id)
      puts "Task deleted successfully!"

    when 3
      print "Enter task ID to edit: "
      id = gets.chomp.to_i
      print "Enter new title (or leave blank): "
      title = gets.chomp
      title = nil if title.empty?
      print "Enter new deadline (YYYY-MM-DD, or leave blank): "
      deadline = gets.chomp
      deadline = nil if deadline.empty?
      print "Enter status (true/false, or leave blank): "
      completed = gets.chomp
      completed = completed.empty? ? nil : completed == 'true'
      manager.edit_task(id, title: title, deadline: deadline, completed: completed)
      puts "Task updated successfully!"

    when 4
      manager.tasks.each do |task|
        puts "ID: #{task[:id]}, Title: #{task[:title]}, Deadline: #{task[:deadline]}, Completed: #{task[:completed]}"
      end

    when 5
      print "Enter status to filter (true/false): "
      status = gets.chomp == 'true'
      tasks = manager.filter_by_status(status)
      tasks.each { |task| puts "ID: #{task[:id]}, Title: #{task[:title]}, Deadline: #{task[:deadline]}, Completed: #{task[:completed]}" }

    when 6
      print "Enter deadline to filter (YYYY-MM-DD): "
      date = gets.chomp
      tasks = manager.filter_by_deadline(date)
      tasks.each { |task| puts "ID: #{task[:id]}, Title: #{task[:title]}, Deadline: #{task[:deadline]}, Completed: #{task[:completed]}" }

    when 7
      puts "Goodbye!"
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end