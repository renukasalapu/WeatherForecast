# app/services/geonames_service.rb

=begin
This Service is used to fetch the country from the zip code
Here we are using geonames api to fetch the country code from zip code
=end
class GeonamesService
  include HTTParty
  base_uri 'http://api.geonames.org'

  def initialize(api_key)
    @api_key = ENV.fetch('GEONAME_API_KEY', '')
  end

  def get_country_with_zip(zip)
    response = self.class.get('/postalCodeLookupJSON', query: { postalcode: zip, username: @api_key })
    if response.success?
      data = JSON.parse(response.body)
      result = data['postalcodes'].first
      result['postalcode']+","+result['countryCode'].downcase rescue ''
    else
      nil
    end
  end
end
