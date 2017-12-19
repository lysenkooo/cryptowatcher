class RatesFetchJob < ApplicationJob
  def perform
    fetch_bittrex_markets
    fetch_poloniex_markets
  rescue => e
    Rails.logger.warn "Error #{e.class.name}: #{e.message}"
  end

  private

  def fetch_bittrex_markets
    response = Faraday.get('https://bittrex.com/api/v1.1/public/getmarketsummaries').body

    JSON.parse(response)['result'].each do |i|
      base, quote = i['MarketName'].split('-')

      Rate.create_with(
        low:  i['Low'],
        high: i['High'],
        bid:  i['Bid'],
        ask:  i['Ask'],
        last: i['Last'],
      ).find_or_create_by!(
        exchange: 'bittrex',
        base_currency: base,
        quote_currency: quote
      )
    end
  end

  def fetch_poloniex_markets
    response = Faraday.get('https://poloniex.com/public?command=returnTicker').body

    JSON.parse(response).each do |market, i|
      base, quote = market.split('_')

      Rate.create_with(
        low:  i['low24hr'],
        high: i['high24hr'],
        bid:  i['highestBid'],
        ask:  i['lowestAsk'],
        last: i['last'],
      ).find_or_create_by!(
        exchange: 'poloniex',
        base_currency: base,
        quote_currency: quote
      )
    end
  end
end
