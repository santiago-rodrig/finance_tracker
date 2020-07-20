class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:sandbox_public_key],
      secret_token: Rails.application.credentials.iex[:sandbox_secret_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    ).price(ticker_symbol)
  end
end
