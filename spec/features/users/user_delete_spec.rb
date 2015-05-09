include Warden::Test::Helpers
Warden.test_mode!

# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise, :js do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can not delete own account
  #   Given I am signed in
  #   When I try to delete my account
  #   Then I should see an account can not be deleted message
  # scenario 'user can not delete own account' do
  #   skip 'skip a slow test'
  #   user = create(:user)
  #   login_as(user, :scope => :user)
  #   visit edit_user_registration_path(user)
  #   click_button 'Cancel my account'
  #   page.driver.browser.switch_to.alert.accept
  #   expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  # end

end




