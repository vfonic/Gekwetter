module ApplicationHelper
  def follow_button(user)
    if current_user.follows?(user)
      button_to 'Unfollow', unfollow_user_path(user.username), class: 'btn btn-danger button-xs'
    else
      button_to 'Follow', follow_user_path(user.username), class: 'btn btn-success button-xs'
    end
  end
end
