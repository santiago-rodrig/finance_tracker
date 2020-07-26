class UpdateCompaniesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    begin
      all_stocks = Stock.all
      all_stocks.each do |s|
        s.update(Stock.new_lookup(s.ticker).to_h)
      end
      UpdateCompaniesJob.set(wait: 1.minute).perform_later
      ActionCable.server.broadcast(
        'stock_changes',
        stocks: all_stocks
      )
    rescue
      nil
    end
  end
end

