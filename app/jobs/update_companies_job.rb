class UpdateCompaniesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Stock.all.each do |s|
      s.update(Stock.new_lookup(s.ticker))
    end
    UpdateCompaniesJob.set(wait: 1.minute).perform_later
    # broadcast changes to the subscribers
  end
end

