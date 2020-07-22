class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @tracked_friends = current_user.friends
  end

  def search_friend
    if params[:friend].present?
      @friends = User.where('first_name LIKE ?', "#{params[:friend]}%")
      @friends = @friends.or(User.where('last_name LIKE ?', "%#{params[:friend]}"))
      @friends = @friends.or(User.where('email LIKE ?', "%#{params[:friend]}%"))
      @error = false
      flash.now.alert = nil
      flash.now.notice = nil
      if @friends.any?
        respond_to do |fmt|
          fmt.js { render 'users/friends_result' }
          fmt.html { render 'users/my_friends' }
        end
      else
        @error = true;
        flash[:alert] = 'No results.'
        respond_to do |fmt|
          fmt.js { render 'users/friends_result' }
          fmt.html { render 'users/my_friends' }
        end
      end
    else
      @error = true
      flash[:alert] = 'Please provide a name or an email.'
      respond_to do |fmt|
        fmt.js { render 'users/friends_result' }
        fmt.html { render 'users/my_friends' }
      end
    end
  end
end
