require 'spec_helper'

describe "Registered user logs in and successfully creates a task" do
  before(:all) do
    @session = Capybara::Session.new(:selenium)
    @session.visit("http://taskme.us")
    @session.click_link("Log In")
  end

  after(:all) do
    @session.find("td.task-title", :text=> @task).click
    @session.find("a", :text=> "Edit Task").click
    @session.find("a", :text=> "Delete Task").click
  end

  let(:user) do
    {
      password: "testtest",
      email: "janmilosh+527329@gmail.com",
      task: "Create some awesome tests"
    }
  end

  it "Should successfully log in user with valid email and password" do
    @session.fill_in "Email", :with => user[:email]
    @session.fill_in "Password", :with => user[:password]
    @session.click_button 'Log in'
    expect(@session).to have_content HOME_CONTENT
    expect(@session).to have_content user[:email]
    expect(@session).to have_content 'Logout'
  end

  it "Should navigate to the tasks page upon clicking 'Tasks' in the header menu" do
    tasks_url = "http://taskme.us/#!/tasks"
    tasks_links = @session.all('a', :text => 'Tasks')
    tasks_links[0].click
    url = @session.current_url
    expect(url).to eq(tasks_url)
  end

  it "Should create a task" do
    @session.fill_in "New task title", :with => user[:task]
    @session.click_button 'add'
    expect(@session).to have_content user[:task]
  end

  it "Should put the task in the inbox" do
    @session.assert_selector('button.list-item', :text => 'Inbox', :visible => true)
  end
end

describe "Unsuccessful log in" do
  
  before(:all) do
    @session = Capybara::Session.new(:selenium) 
  end

  before do
    @session.visit("http://taskme.us")
    @session.click_link("Log In")
  end

  let(:user) do
    {
      password: "wrongpassword",
      email: "janmilosh+527329@gmail.com",
      wrong_email: "janmilosh+111111@gmail.com"
    }
  end

  it "Should give an incorrect password error with registered user and wrong password" do
    @session.fill_in "Email", :with => user[:email]
    @session.fill_in "Password", :with => user[:password]
    @session.click_button 'Log in'
    expect(@session).to have_content "Error: FirebaseSimpleLogin: FirebaseSimpleLogin: The specified password is incorrect."
  end

  it "Should give a user does not exist error with non-registered user" do
    @session.fill_in "Email", :with => user[:wrong_email]
    @session.fill_in "Password", :with => user[:password]
    @session.click_button 'Log in'
    expect(@session).to have_content "Error: FirebaseSimpleLogin: FirebaseSimpleLogin: The specified user does not exist."
  end
end