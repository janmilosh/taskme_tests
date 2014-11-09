require 'capybara/rspec'

Capybara.run_server = false
Capybara.default_wait_time = 5

class RandomEmailFactory
  def self.create_email(prefix, suffix)
    random_number = rand(100000..1000000)
    email = prefix + '+' + random_number.to_s + suffix
  end
end