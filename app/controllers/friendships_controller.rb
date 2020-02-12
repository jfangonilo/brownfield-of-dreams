class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_id: params[:friendship][:friend_github_id])

    user_id = params[:friendship][:user_id]

    friendship = Friendship.new(user_id: user_id, friended_user_id: friend.id)

    if friendship.save
      flash[:success] = "#{friend.first_name} is now your friend!"
      redirect_to "/dashboard"
    else
      flash[:error] = "Something went wrong. Can't add friend"
      redirect_to "/dashboard"
    end
  end
end
