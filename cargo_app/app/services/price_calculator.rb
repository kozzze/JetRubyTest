require 'net/http'
require 'json'

class PriceCalculator
  attr_reader :distance, :price

  def initialize(order)
    @order = order
    @distance = fetch_distance
    @price = calculate_price
  end

  def volume
    (@order.length / 100.0) * (@order.width / 100.0) * (@order.height / 100.0)
  end

  def calculate_price
    rate =
      if volume < 1
        1
      elsif volume >= 1 && @order.weight <= 10
        2
      else
        3
      end

    (@distance * rate).round(2)
  end

  def fetch_distance
    api_key = ENV['DISTANCEMATRIX_API_KEY']
    uri = URI("https://api.distancematrix.ai/maps/api/distancematrix/json")
    uri.query = URI.encode_www_form({
      origins: @order.from_city,
      destinations: @order.to_city,
      key: api_key
    })
  
    response = Net::HTTP.get_response(uri)
    body = JSON.parse(response.body)
  
    puts "DEBUG: API raw response = #{body.inspect}" # ← добавь это
  
    if response.is_a?(Net::HTTPSuccess) &&
       body["rows"] &&
       body["rows"][0] &&
       body["rows"][0]["elements"] &&
       body["rows"][0]["elements"][0] &&
       body["rows"][0]["elements"][0]["status"] == "OK"
  
      (body["rows"][0]["elements"][0]["distance"]["value"] / 1000.0).round
    else
      raise "Ошибка API: #{body['error_message'] || body['status'] || 'не удалось получить расстояние'}"
    end
  end
end