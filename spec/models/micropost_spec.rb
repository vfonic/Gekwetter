# ## Schema Information
#
# Table name: `microposts`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`content`**     | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`user_id`**     | `integer`          |
#
# ### Indexes
#
# * `index_microposts_on_created_at`:
#     * **`created_at`**
# * `index_microposts_on_user_id`:
#     * **`user_id`**
#

require 'rails_helper'

RSpec.describe Micropost, type: :model do

  describe "timeline" do
    before(:each) do
      @user = create(:user)
      @other_user = create(:user)
      @third_user = create(:user)
      @fourth_user = create(:user)
      
      @user.microposts.create!(:content => "foo")
      @other_post = @other_user.microposts.create!(:content => "bar")
      @third_post = @third_user.microposts.create!(:content => "baz")
      @fourth_post = @fourth_user.microposts.create!(:content => "baza")
      
      @user.follow!(@other_user)
      @user.follow!(@third_user)
    end

    subject { Micropost }
    it { should respond_to(:timeline).with(1).argument }

    it "should contain created microposts" do
      @user.microposts.count.should_not be_zero
      @other_user.microposts.count.should_not be_zero
      @third_user.microposts.count.should_not be_zero
    end

    it "should include the followed users' microposts" do
      Micropost.timeline(@user).include?(@other_post).should be_truthy
      Micropost.timeline(@user).include?(@third_post).should be_truthy
    end

    it "should not include the user's own microposts" do
      Micropost.timeline(@user).include?(@user_post).should be_falsy
    end

    it "should not include an unfollowed user's microposts" do
      Micropost.timeline(@user).include?(@fourth_post).should be_falsy
    end
  end
end
