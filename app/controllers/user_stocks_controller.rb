class UserStocksController < ApplicationController
  def create
    ticker = params[:stock_ticker]
    user = User.find(params[:user])
    stock = Stock.find_by(ticker: ticker) || Stock.new_lookup(ticker)
    stock.save
    @user_stock = UserStock.create(user: user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio."
    redirect_to my_portfolio_url
  end

  def destroy
    @user_stock = UserStock.find_by(user_id: params[:user], stock_id: params[:stock_tracked])
    @user = User.find(params[:user])
    @user_stock&.destroy
    @tracked_stocks = @user.reload.stocks
    flash.now[:notice] = 'Stock was successfully deleted.'
    respond_to do |fmt|
      fmt.js { render }
      fmt.html { render 'users/my_portfolio' }
    end
  end
end
