require 'spec_helper'

feature 'Signing in/out' do
  before(:all) { GithubUser.delete_all }

  context 'a new user' do
    scenario 'visiting /contact' do
      visit '/contact'

      page.should have_content 'Drop me a line'
    end

    scenario 'Sees sign up button' do
      visit '/'
      page.should have_content 'Get emails of gist comments!'
      page.should have_link 'Sign up via Github'

      visit '/about'
      page.should have_link 'Sign up via Github'
    end

    scenario 'clicking the button signs in via github' do
      visit "/auth/github"
      current_path.should =~ /github_users\/\d+\/edit/
      page.should have_content 'Mister Bob'
      page.should have_content "Please correct your email address"
    end

    scenario 'correcting email address', js: true do
      visit "/auth/github"
      fill_in 'github_user_email', with: 'correct@example.com'
      click_button 'Save'

      current_path.should =~ /github_users\/\d+\/edit/
      page.should have_content 'Mister Bob'
      page.should_not have_content "Please correct your email address"
      page.should have_content "It looks like we don't have any information on your gists yet"
    end

    %w(/ /about).each do |path|
      scenario "visiting #{path}" do
        visit "/auth/github"
        visit path

        page.should have_content 'Thanks for signing up'
        page.should_not have_link 'Sign up via Github'
        page.should have_link 'Update your email address and view your gists'
      end
    end

    scenario 'deactivating account', js: true do
      visit "/auth/github"
      uncheck "github_user_active"
      click_button 'Save'
      current_path.should =~ /github_users\/\d+\/edit/
      visit current_path
      page.should have_unchecked_field "github_user_active"
    end

    #scenario 'not wanting GCE to see private gists', js: true do
    #  visit "/auth/github"
    #  uncheck "github_user_include_private_gists"
    #  click_button 'Save'
    #  current_path.should =~ /github_users\/\d+\/edit/
    #  visit current_path
    #  page.should have_unchecked_field "github_user_include_private_gists"
    #end

    scenario 'signing out' do
      visit "/auth/github"
      click_link 'Sign out'
      page.should have_content 'Signed out of Gist Comment Emailer (note you remained signed into Github due to oauth)'
    end
  end
end
