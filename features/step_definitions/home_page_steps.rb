Given(/^there's a post with "(.*?)" content$/) do |content|
  @user = FactoryGirl.create(:user)
  @post = FactoryGirl.create(:micropost, content: content, user: @user)
end

When(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see the "(.*?)" post$/) do |content|
  @post = Micropost.find_by_content(content)

  page.should have_content(@post.content)
end
