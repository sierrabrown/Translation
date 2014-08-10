require 'spec_helper'
feature "Sign up" do
  before :each do
    visit "/session/new"
  end

  it "has a user sign up page" do
    page.should have_content "Sign Up"
  end

  it "validates the presence of the user's username" do
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
    page.should have_content "Username can't be blank"
  end

  it "rejects a blank (zero-length) password" do
    fill_in "Username", with: 'hello_world'
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
    page.should have_content 'Password is too short (minimum is 6 characters)'
  end

  it "validates that the password is at least 6 characters long" do
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'short'
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
    page.should have_content 'Password is too short (minimum is 6 characters)'
  end

  it "logs the user in and redirects them to speakeasy home on success" do
    sign_up_as_hello_world
    # add user name to application.html.erb layout
    page.should have_content 'Home'
  end
end

feature "Sign out" do
  it "has a sign out button" do
    sign_up_as_hello_world
    page.should have_link 'Sign Out'
  end

  it "after logout, a user is  not allowed access to the home page" do
    sign_up_as_hello_world

    click_link 'Sign Out'
    visit '/#/home'

    # redirect to login page
    page.should have_content 'Sign Up'
  end
end
