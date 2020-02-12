class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_id: params[:friendship][:friend_github_id])

    user_id = params[:friendship][:user_id]

    Friendship.create(user_id: user_id, friended_user_id: friend.id)

    render :dashboard_path
  end
end
