class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks, dependent: :destroy
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def max_reached?
    stocks.count >= 10
  end

  def stock_exists?(ticker_symbol)
    !!stocks.find_by(ticker: ticker_symbol)
  end

  def can_track_stock?(ticker_symbol)
    !(max_reached? || stock_exists?(ticker_symbol))
  end

  def can_track_friend?(friend)
    !(friends.include?(friend) || friend == self)
  end

  def full_name
    ((first_name || last_name) && "#{first_name} #{last_name}") || 'Anonymous'
  end
end

