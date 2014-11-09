require 'capybara/rspec'

Capybara.run_server = false
Capybara.default_wait_time = 5

HOME_CONTENT = "TaskMe is todo list/task organization application based on the methods from the book Getting Things Done by David Allen."

class RandomEmailFactory
  def self.create_email(prefix, suffix)
    random_number = rand(100000..1000000)
    email = prefix + '+' + random_number.to_s + suffix
  end
end