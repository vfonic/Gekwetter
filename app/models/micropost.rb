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

class Micropost < ActiveRecord::Base
  default_scope { order(created_at: :desc).includes(:user) }
  belongs_to :user

  validates :content,
    presence: true,
    length: { maximum: 160 }

  def self.timeline(user)
    self.joins(:user).where(user: user.following)
  end

  def as_json(options = {})
    {
      id: id,
      content: content,
      created_at: created_at
    }
  end
end
