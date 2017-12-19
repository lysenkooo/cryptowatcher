class Rate < ApplicationRecord
  enum exchange: [:bittrex, :poloniex]
end
