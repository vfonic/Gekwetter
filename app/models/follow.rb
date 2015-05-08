# ## Schema Information
#
# Table name: `follows`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`followable_type`**  | `string`           |
# **`follower_type`**    | `string`           |
# **`created_at`**       | `datetime`         |
# **`followable_id`**    | `integer`          |
# **`follower_id`**      | `integer`          |
#
# ### Indexes
#
# * `fk_followables`:
#     * **`followable_id`**
#     * **`followable_type`**
# * `fk_follows`:
#     * **`follower_id`**
#     * **`follower_type`**
#

class Follow < Socialization::ActiveRecordStores::Follow
end
