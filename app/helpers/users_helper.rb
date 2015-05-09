module UsersHelper
  def following_link
    link_to "#{@user.following_count} following", following_user_path(@user)
  end

  def followers_link
    link_to(followers_user_path(@user)) do
      "#{@user.followers_count} " +
      "#{"follower".pluralize(@user.followers_count)}"
    end
  end
end
