defmodule CurrentWeather.YahooFetcher do
  def fetch(woeid) do
    body = get(woeid)
    temp = extract_temperature(body)
    temp
  end

  def extract_temperature(body) do
    # extract temperature from body
    IO.puts body
  end

  def get(woeid) do
    {:ok, 200, _headers, client} = :hackney.get(url_for(woeid))
    {:ok, body} = :hackney.body(client)
    body
  end

  def url_for(woeid) do
    base_url <> woeid
  end

  def base_url do
    "http://weather.yahooapis.com/forecastrss?w="
  end
end
