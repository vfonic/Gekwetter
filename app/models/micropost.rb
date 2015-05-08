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
# * `index_microposts_on_user_id`:
#     * **`user_id`**
#

class Micropost < ActiveRecord::Base
  belongs_to :user
end
