module UsersHelper
  def following_link(count)
    link_to "#{@user.following.count} following", following_user_path(@user)
  end

  def followers_link(count)
    link_to(followers_user_path(@user)) do
      "#{@user.followers.count} " +
      "#{"follower".pluralize(@user.followers.count)}"
    end
  end
end
