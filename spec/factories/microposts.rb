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

FactoryGirl.define do
  factory :micropost do
    sequence(:content) { |n| "My status message ##{n}" }
    user_id 1
  end
end
