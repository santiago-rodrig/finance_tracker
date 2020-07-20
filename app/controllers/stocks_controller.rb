class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |fmt|
          fmt.js { render partial: 'users/result' }
          fmt.html { render 'users/my_portfolio' }
        end
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
