class FriendshipsController < ApplicationController
  before_action :require_user
  def index
    @followings = current_user.friendships || []
  end

  def create
    @friendship = Friendship.new(user:current_user, friend_id:params[:friend_id])

    if current_user.can_follow?(User.find(params[:friend_id])) && @friendship.save
      flash[:success] = "Follow successfully!"
      redirect_to users_path(params[:friend_id])
    else
      flash[:error] = "Follow failed!"
      @followings = current_user.friendships || []
      render "friendships/index"
    end

  end

  def destroy
    if Friendship.exists?(id: params[:id], user_id: current_user.id)
      Friendship.find_by(id: params[:id], user_id: current_user.id).delete
    end
    redirect_to people_path
  end
end
