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

describe Micropost, type: :model do
  context "validate" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(160) }
  end

  context '::timeline' do
    before(:each) do
      @user = create(:user)
      @other_user = create(:user)
      @third_user = create(:user)
      @fourth_user = create(:user)

      @user.microposts.create!(content: 'foo')
      @other_post = @other_user.microposts.create!(content: 'bar')
      @third_post = @third_user.microposts.create!(content: 'baz')
      @fourth_post = @fourth_user.microposts.create!(content: 'baza')

      @user.follow!(@other_user)
      @user.follow!(@third_user)
    end

    subject { Micropost }

    it { should respond_to(:timeline).with(1).argument }
    it { should respond_to(:timeline).with(2).arguments }

    it 'should contain created microposts' do
      expect(@user.microposts.count).to be 1
      expect(@other_user.microposts.count).to be 1
      expect(@third_user.microposts.count).to be 1
    end

    it "should include the followed users' microposts" do
      expect(Micropost.timeline(@user)).to include(@other_post)
      expect(Micropost.timeline(@user)).to include(@third_post)
    end

    it "should not include the user's own microposts" do
      expect(Micropost.timeline(@user)).not_to include(@user_post)
    end

    it "should not include an unfollowed user's microposts" do
      expect(Micropost.timeline(@user)).not_to include(@fourth_post)
    end
  end
end
