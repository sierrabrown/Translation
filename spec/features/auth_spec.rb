require 'spec_helper'
feature "Sign up" do
  before :each do
    visit "/session/new"
  end

  it "has a user sign up page" do
    page.should have_content "Sign Up"
  end

  #it "takes a username and password" do
  #  page.should have_content "Username"
  #  page.should have_content "Password"
  #end

  it "validates the presence of the user's username" do
    click_button 'Sign In'
    page.should have_content 'Sign Up'
    page.should have_content "Invalid username or password"
  end

  it "rejects a blank (zero-length) password" do
    fill_in "Username", with: 'hello_world'
    click_button 'Sign In'
    page.should have_content 'Sign In'
    page.should have_content 'Invalid username or password'
  end

  it "validates that the password is at least 6 characters long" do
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'short'
    click_button 'Sign In'
    page.should have_content 'Sign In'
    page.should have_content 'Invalid username or password'
  end

  it "logs the user in and redirects them to speakeasy home on success" do
    sign_up_as_hello_world
    # add user name to application.html.erb layout
    page.should have_content 'INSTANT MACHINE TRANSLATION'
  end
end

feature "Sign out" do
  it "has a sign out button" do
    sign_up_as_hello_world
    page.should have_button 'Sign Out'
  end

  it "after logout, a user is  not allowed access to links index" do
    sign_up_as_hello_world

    click_button 'Sign Out'
    visit '/links'

    # redirect to login page
    page.should have_content 'Sign In'
    page.should have_content "Username"
  end
end

feature "Sign in" do
  it "has a sign in page" do
    visit "/session/new"
    page.should have_content "Sign In"
  end


  it "returns to sign in on failure" do
    visit "/session/new"
    fill_in "username", with: 'hello_world'
    fill_in "Password", with: 'hello'
    click_button "Sign In"

    # return to sign-in page
    page.should have_content "Sign In"
  end

  it "takes a user to speaeasky home on success" do
    sign_up_as_hello_world
    # add button to sign out in application.html.erb layout
    click_button 'Sign Out'

    # Sign in as newly created user
    visit "/session/new"
    fill_in "username", with: 'hello_world'
    fill_in "password", with: 'abcdef'
    click_button "Sign In"
    page.should have_content "INSTANT MACHINE TRANSLATION"
  end
end
