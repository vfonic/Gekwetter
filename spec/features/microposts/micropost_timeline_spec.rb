include Warden::Test::Helpers
Warden.test_mode!

# Feature: Micropost timeline
#   As a user
#   I want to visit home page
#   So I can see posts from users I follow
feature 'Micropost timeline', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Micropost timeline
  #   Given I am signed in
  #   When I visit home page
  #   Then I can see posts from users I follow
  scenario 'user sees timeline' do
    me = create(:user)
    other = create(:user)
    third = create(:user)
    fourth = create(:user)
    micropost_content = 'micropost content'
    micropost_content2 = 'micropost content2'
    micropost_content3 = 'micropost content3'
    micropost_content4 = 'micropost content4'
    other.microposts << create(:micropost, content: micropost_content)
    other.microposts << create(:micropost, content: micropost_content2)
    third.microposts << create(:micropost, content: micropost_content3)
    fourth.microposts << create(:micropost, content: micropost_content4)
    me.follow! other
    me.follow! third
    login_as(me, scope: :user)

    visit root_path
    expect(page).to have_content micropost_content
    expect(page).to have_content micropost_content2
    expect(page).to have_content micropost_content3
    expect(page).not_to have_content micropost_content4
  end
end
