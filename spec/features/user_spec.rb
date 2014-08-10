require 'spec_helper'
feature "user profile" do

  before :each do
    visit "/session/new"
    demo_sign_in
  end

  it "displays content" do
    page.should have_content "cooleschool"
  end

  # it "validates the presence of the user's username" do
#     click_button 'Sign Up'
#     page.should have_content 'Sign Up'
#     page.should have_content "Username can't be blank"
#   end
#
#   it "rejects a blank (zero-length) password" do
#     fill_in "Username", with: 'hello_world'
#     click_button 'Sign Up'
#     page.should have_content 'Sign Up'
#     page.should have_content 'Password is too short (minimum is 6 characters)'
#   end
#
#   it "validates that the password is at least 6 characters long" do
#     fill_in "Username", with: 'hello_world'
#     fill_in "Password", with: 'short'
#     click_button 'Sign Up'
#     page.should have_content 'Sign Up'
#     page.should have_content 'Password is too short (minimum is 6 characters)'
#   end
#
#   it "logs the user in and redirects them to speakeasy home on success" do
#     sign_up_as_hello_world
#     # add user name to application.html.erb layout
#     page.should have_content 'Home'
#   end
end