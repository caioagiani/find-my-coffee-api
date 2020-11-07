require "rest-client"
require "json"

class GoogleDetailsCoffeeService
  def initialize(google_place_id)
    @google_place_id = google_place_id
  end

  def call
    base_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{@google_place_id}&key=#{Rails.application.credentials.google_secret_key}"

    response = RestClient.get(base_url)

    JSON.parse(response.body)
  end
end
