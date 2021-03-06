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

class User < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  acts_as_follower
  acts_as_followable

  extend FriendlyId
  friendly_id :username

  before_save :downcase_username_and_email

  attr_accessor :login

  has_many :microposts

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z0-9]+\z/i }

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).find_by(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }])
    else
      find_by(conditions.to_hash)
    end
  end

  def downcase_username_and_email
    self.username = username.downcase
    self.email = email.downcase
  end

  def as_json(_ = {})
    {
      name: name || '',
      username: username || '',
      followers: followers.count,
      following: following.count
    }
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, # :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
