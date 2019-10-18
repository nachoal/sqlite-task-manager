# frozen_string_literal: true

# CRUD WITH SQL LIVECODE - Oct 18, 2019
# Made by Batch 335
class Task
  attr_reader :id
  attr_accessor :title, :description, :done
  def initialize(attributes = {})
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || 0
    @id = attributes[:id]
  end

  def self.find(id)
    DB.results_as_hash = true
    result_as_hash = DB.execute('SELECT * FROM tasks WHERE id=?', id).first
    Task.new(
      title: result_as_hash['title'],
      description: result_as_hash['description'],
      done: result_as_hash['done'],
      id: result_as_hash['id']
    )
  end

  # 2. Implement the CREATE logic in a save instance method
  def save
    # 2.1 First check if the @id exists
    if @id
      # 2.3 IF it does THEN UPDATE
      DB.execute(
        'UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?',
        @title, @description, @done, @id
      )
    else
      # 2.4 IF NOT THEN CREATE/INSERT
      DB.execute(
        'INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)',
        @title, @description, @done
      )
      # 2.5 After INSERTING we GET LAST_CREATED_ID  and assign to @id
      @id = DB.last_insert_row_id
    end
  end

  # 3 Imlement the READ logic to retrieve all tasks (what type of method is it?)
  # 3.1 Query the DB for all the ROWS
  # 3.2 Convert the hash into an instance of Task (FOR ALL FOUND VALUES)
  # RETURN AN ARRAY OF INSTANCES OF Tasks
  def self.all
    results_hash_array = DB.execute('SELECT * FROM tasks')
    results_hash_array.map do |task|
      Task.new(
        title: task['title'],
        description: task['description'],
        id: task['id'],
        done: task['done']
      )
    end
  end

  # 4. Implement the DESTROY logic on a task
  # 4.1 Define an INSTANCE method that deletes the instance
  # 4.2 Build the Query to delete the instance
  def destroy
    DB.execute('DELETE FROM tasks WHERE id LIKE ?', @id)
  end
end
