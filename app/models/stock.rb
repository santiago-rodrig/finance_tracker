class Stock < ApplicationRecord
  has_many :user_stocks, dependent: :destroy
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex[:sandbox_public_key],
        secret_token: Rails.application.credentials.iex[:sandbox_secret_key],
        endpoint: 'https://sandbox.iexapis.com/v1'
      )
      new(
        ticker: ticker_symbol,
        name: client.company(ticker_symbol).company_name,
        last_price: client.price(ticker_symbol)
      )
    rescue
      nil
    end
  end

  def to_h
    attributes.reject do |k, v|
      %w[id created_at updated_at].include?(k)
    end
  end
end
