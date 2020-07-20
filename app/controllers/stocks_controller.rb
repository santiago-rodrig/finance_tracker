class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        render 'users/my_portfolio'
      else
        flash[:alert] = 'Symbol not found.'
        redirect_to my_portfolio_url
      end
    else
      flash[:alert] = 'Please enter a symbol to search.'
      redirect_to my_portfolio_url
    end
  end
end
