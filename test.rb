# Require Sqlite3 so that we can instantiate the data from our DB
require "sqlite3"
# Generate the DB to query
db_file_path = "tasks.db"
DB = SQLite3::Database.new(db_file_path)
# Configure our DB results to be hashes (see your lecture's last part)
DB.results_as_hash = true

# Require our Task file to use it
require_relative "task"

# Insert a first record to have something to start with
DB.execute("INSERT INTO tasks (title, description) VALUES ('Complete Livecode', 'Implement CRUD on Task');")

# Write your test code here (and run `ruby test.rb` in your terminal to run it):

# CRUD Task

# 1. Implement the READ logic to find a given task (by its id) - (Class.find(id))
p Task.find(1) # We need to select only one task

# 2. Implement the CREATE logic in a save instance method - (instance.save)
task = Task.new(title: 'Watch the luchas', description: "Watch sweaty men fight")
task.save

# 3. Implement the UPDATE logic in the same method
task = Task.find(1)
task.title = "Adopt a cat"
task.save
# 4. Implement the READ logic to retrieve all tasks (what type of method is it?) - Class.all
p Task.all

# 5. Implement the DESTROY logic on a task
task.destroy
