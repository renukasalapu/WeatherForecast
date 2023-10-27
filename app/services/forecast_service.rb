require 'httparty'

=begin
Forecast Service is used to fetch the weather based upon the zip code
Here we are using openweathermap api, to fetch the weather details
By default the units of response is Kelvin
=end

class ForecastService
	include HTTParty

	base_uri 'https://api.openweathermap.org'


	def initialize(api_key)
		@api_key = ENV.fetch('FORECAST_API_KEY', '')
	end

	def get_zip_with_country(zip)
		geonames_service = GeonamesService.new('renuka.s07')
		country_code = geonames_service.get_country_with_zip(zip)
	end

	def get_forecast_data(zip)
		zip_with_country = get_zip_with_country(zip)
		response = self.class.get('/data/2.5/weather', query: {zip:zip_with_country, appid: @api_key })
		puts response.inspect
		if response.success?
			response['main']
		else
			raise response.message
		end
	end


end