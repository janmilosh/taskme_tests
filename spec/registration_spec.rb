require 'spec_helper'

describe "Register and create a new user account" do
    
  before(:all) do
    prefix = 'janmilosh'
    suffix = '@gmail.com'
    @email = RandomEmailFactory.create_email(prefix, suffix)

    @session = Capybara::Session.new(:selenium) 
    @session.visit("http://taskme.us")
  end

  let(:user) do
    {
      password: "testtest",
      email: @email
    }
  end

  it "Should navigate to the 'Home' page" do
    expect(@session).to have_content HOME_CONTENT
  end

  it "Should navigate to the registration page when 'Register' is clicked" do
    register_url = "http://taskme.us/#!/register"
    @session.click_link 'Register'
    url = @session.current_url
    expect(url).to eq(register_url)
  end

  it "Should fill out the registration form" do
    @session.fill_in "Email", :with => user[:email]
    @session.fill_in "Password", :with => user[:password]
    @session.fill_in "Confirm Password", :with => user[:password]
  end

  it "Should navigate to the 'Home' page as a logged-in user after clicking 'Register'" do
    @session.click_button 'Register'
    expect(@session).to have_content HOME_CONTENT
    expect(@session).to have_content user[:email]
    expect(@session).to have_content 'Logout'
  end

  it "Should navigate to the lists page when 'List' is clicked" do
    list_url = "http://taskme.us/#!/lists"
    list_links = @session.all('a', :text => 'List')
    list_links[0].click
    url = @session.current_url
    expect(url).to eq(list_url)
  end

  it "List page should have the three default lists" do
    @session.assert_selector('td', :text => 'Today', :visible => true)
    @session.assert_selector('td', :text => 'Soon', :visible => true)
    @session.assert_selector('td', :text => 'Inbox', :visible => true)
  end

end