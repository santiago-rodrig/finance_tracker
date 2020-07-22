class FriendshipsController < ApplicationController
  def index
    redirect_to my_friends_url
  end

  def create
    user = User.find(params[:user])
    @friend = User.find(params[:new_friend])
    user.friends << @friend
    @tracked_friends = user.reload.friends
    flash.now.alert = nil
    flash.now[:notice] = 'Friend successfully added.'
    respond_to do |fmt|
      fmt.js { render 'friendships/create' }
      fmt.html { render 'users/my_friends' }
    end
  end

  def destroy
    @friend = User.find(params[:tracked_friend])
    friendship = Friendship.find_by(user_id: params[:user], friend_id: params[:tracked_friend])
    friendship&.destroy
    @tracked_friends = current_user.reload.friends
    flash.now.alert = nil
    flash.now.notice = "You are no longer following #{@friend.full_name}.";
    respond_to do |fmt|
      fmt.js { render 'friendships/destroy' }
      fmt.html { render 'users/my_friends' }
    end
  end
end
