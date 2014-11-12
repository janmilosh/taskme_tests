require 'capybara/rspec'

Capybara.run_server = false
Capybara.default_wait_time = 5

HOME_CONTENT = "TaskMe is todo list/task organization application based on the methods from the book Getting Things Done by David Allen."