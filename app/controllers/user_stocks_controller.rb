class UserStocksController < ApplicationController
  def create
    ticker = params[:stock_ticker]
    user = User.find(params[:user])
    @stock = Stock.find_by(ticker: ticker) || Stock.new_lookup(ticker)
    @stock.save
    @is_profile = params[:user_profile].present?
    @user_stock = UserStock.create(user: user, stock: @stock)
    if @is_profile
      @user = User.find(params[:user_profile])
      @tracked_stocks = @user.reload.stocks
    else
      @tracked_stocks = current_user.reload.stocks
    end
    flash.now[:notice] = "Stock #{@stock.name} was successfully added to your portfolio."
    respond_to do |fmt|
      fmt.js { render 'create' }
      if @is_profile
        fmt.html { render 'users/show' }
      else
        fmt.html { render 'users/my_portfolio' }
      end
    end
  end

  def destroy
    @user_stock = UserStock.find_by(user_id: params[:user], stock_id: params[:stock_tracked])
    @stock = @user_stock.stock
    @ticker = @stock.ticker
    @user = User.find(params[:user])
    @user_stock&.destroy
    @is_profile = params[:user_profile]
    @tracked_stocks = @user.reload.stocks
    flash.now[:notice] = 'Stock was successfully deleted.'
    respond_to do |fmt|
      fmt.js { render }
      if params[:user_profile].present?
        fmt.html { render 'users/show' }
      else
        fmt.html { render 'users/my_portfolio' }
      end
    end
  end
end

