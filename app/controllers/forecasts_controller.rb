class ForecastsController < ApplicationController
  def location
    url_safe_address = URI.encode(params[:address])

    full_url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_address
    raw_data = open(full_url).read
    parsed_data = JSON.parse(raw_data)

    the_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    the_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    full_url = "https://api.forecast.io/forecast/048adcb08a629d1532b3b963652b9288/" + the_latitude + "," + the_longitude
    raw_data = open(full_url).read
    parsed_data = JSON.parse(raw_data)

    @the_address = url_safe_address
    @the_temperature = parsed_data["currently"]["temperature"]
    @the_hour_outlook = parsed_data["hourly"]["data"][0]["summary"]
    @the_day_outlook = parsed_data["daily"]["data"][0]["summary"]

  end
end
