require 'minitest/autorun'
require_relative 'task_manager'

class TaskManagerTest < Minitest::Test
  def setup
    @test_file = 'test_tasks.json'
    @manager = TaskManager.new(@test_file)
  end

  def teardown
    File.delete(@test_file) if File.exist?(@test_file)
  end

  def test_add_task
    @manager.add_task('Test Task', '2024-12-31')
    assert_equal 1, @manager.tasks.size
    assert_equal 'Test Task', @manager.tasks.first[:title]
  end

  def test_delete_task
    @manager.add_task('Test Task', '2024-12-31')
    task_id = @manager.tasks.first[:id]
    @manager.delete_task(task_id)
    assert_empty @manager.tasks
  end

  def test_edit_task
    @manager.add_task('Old Task', '2024-12-31')
    task_id = @manager.tasks.first[:id]
    @manager.edit_task(task_id, title: 'New Task', completed: true)
    task = @manager.tasks.first
    assert_equal 'New Task', task[:title]
    assert_equal true, task[:completed]
  end

  def test_filter_by_status
    @manager.add_task('Task 1', '2024-12-31')
    @manager.add_task('Task 2', '2024-12-31')
    @manager.edit_task(@manager.tasks.first[:id], completed: true)
    completed_tasks = @manager.filter_by_status(true)
    assert_equal 1, completed_tasks.size
  end

  def test_filter_by_deadline
    @manager.add_task('Task 1', '2024-01-01')
    @manager.add_task('Task 2', '2024-12-31')
    tasks = @manager.filter_by_deadline('2024-06-01')
    assert_equal 1, tasks.size
    assert_equal 'Task 1', tasks.first[:title]
  end
end