# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`confirmation_sent_at`**    | `datetime`         |
# **`confirmation_token`**      | `string`           |
# **`confirmed_at`**            | `datetime`         |
# **`current_sign_in_at`**      | `datetime`         |
# **`current_sign_in_ip`**      | `inet`             |
# **`email`**                   | `string`           | `default(""), not null`
# **`encrypted_password`**      | `string`           | `default(""), not null`
# **`followers_count`**         | `integer`          | `default(0)`
# **`following_count`**         | `integer`          | `default(0)`
# **`last_sign_in_at`**         | `datetime`         |
# **`last_sign_in_ip`**         | `inet`             |
# **`name`**                    | `string`           |
# **`remember_created_at`**     | `datetime`         |
# **`reset_password_sent_at`**  | `datetime`         |
# **`reset_password_token`**    | `string`           |
# **`role`**                    | `integer`          |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`unconfirmed_email`**       | `string`           |
# **`username`**                | `string`           |
# **`created_at`**              | `datetime`         |
# **`updated_at`**              | `datetime`         |
#
# ### Indexes
#
# * `index_users_on_created_at`:
#     * **`created_at`**
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_users_on_username` (_unique_):
#     * **`username`**
#

FactoryGirl.define do
  factory :user do
    # confirmed_at Time.now
    sequence(:username) { |n| "Test#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'please123'
  end

  factory :admin, class: User do
    # confirmed_at Time.now
    sequence(:username) { |n| "Admin#{n}" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    password 'please123'

    trait :admin do
      role 'admin'
    end
  end
end
