require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    url.concat(sanitized_street_address)
    url.concat("&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78")
    
    parsed_data = JSON.parse(open(url).read)
    @latitude = parsed_data.dig("results", 0, "geometry", "location", "lat").to_s
    @longitude = parsed_data.dig("results", 0, "geometry", "location", "lng").to_s
    
    url2 = "https://api.darksky.net/forecast/f1b8a0d3e145a4b3697be1b56a370515/"
    url2.concat(@latitude)
    url2.concat(",")
    url2.concat(@longitude)

    parsed_results = JSON.parse(open(url2).read)
    
    @current_temperature = parsed_results.dig("currently", "temperature")

    @current_summary = parsed_results.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_results.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_results.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_results.dig("daily", "summary")

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
