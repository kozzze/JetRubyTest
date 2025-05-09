require 'net/http'
require 'json'
require 'dotenv/load'


class Cargo
  attr_reader :weigth, :lenght, :width, :height, :from, :to, :distance, :price

  def initialize 
    input_parameters
    @distance = distance(@from, @to)
    @price = calculate_price
  end
  
  def input_parameters
    print "Введите вес: "
    @weigth = gets.to_f
    print "Введите длину: "
    @lenght = gets.to_f
    print "Введите ширину: "
    @width = gets.to_f
    print "Введите высоту: "
    @height = gets.to_f
    print "Введите пункт отправления:"
    @from = gets.chomp
    print "Введите пункт назначения:"
    @to = gets.chomp
  end

  def distance(from, to)
    api_key = ENV['DISTANCEMATRIX_API_KEY']
    base_url = "https://api.distancematrix.ai/maps/api/distancematrix/json"
    uri = URI(base_url)
    uri.query = URI.encode_www_form({
      origins: from,
      destinations: to,
      key: api_key
    })
    response = Net::HTTP.get_response(uri)
    body = JSON.parse(response.body)

    if response.is_a?(Net::HTTPSuccess) && body["rows"] && body["rows"][0]["elements"][0]["status"] == "OK"
      meters = body["rows"][0]["elements"][0]["distance"]["value"]
      (meters / 1000.0).round 
    else
      raise "Ошибка запроса к API: #{body["error_message"] || 'Не удалось получить расстояние'}"
    end
    
  end

  def calc_lovume
    (@lenght / 100.0) * (@height / 100.0) * (@width / 100.0)  
  end

  def calculate_price
    volume = calc_lovume
    rate = 
      if volume < 1
        1
      elsif volume >= 1 && @weigth <= 10
        2
      elsif volume >= 1 && @weigth > 10
        3
      end

      (@distance * rate).round(2)
  end

  def to_s
    "Откуда: #{@from},
    Куда: #{@to},
    Расстояние: #{@distance} км,
    Вес: #{@weigth} кг,
    Длина: #{@lenght} см,
    Ширина: #{@width} см,
    Высота: #{@height} см
    Итоговая стоимость: #{@price} руб."
  end
    
end

  delivery = Cargo.new
  puts "\nРезультат:"
  puts delivery.to_s
