class WeatherApi

  def self.fetch_weather(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q="
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    @weather = response
  end

  def self.key
    raise "APIKEY2 (Weather api) environment variable not defined" if ENV['APIKEY2'].nil?
    ENV['APIKEY2']
  end
end
