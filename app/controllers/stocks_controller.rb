class StocksController < ApplicationController
  def search
    @tracked_stocks = current_user.stocks
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        flash.now.notice = nil
        flash.now.alert = nil
        respond_to do |fmt|
          fmt.js { render partial: 'users/result' }
          fmt.html { render 'users/my_portfolio' }
        end
      else
        flash.now[:alert] = 'Symbol not found.'
        respond_to do |fmt|
          fmt.js { render partial: 'users/result' }
          fmt.html { render 'users/my_portfolio' }
        end
      end
    else
      flash.now[:alert] = 'Please enter a symbol to search.'
      respond_to do |fmt|
        fmt.js { render partial: 'users/result' }
        fmt.html { render 'users/my_portfolio' }
      end
    end
  end
end

