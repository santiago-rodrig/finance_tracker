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
end
