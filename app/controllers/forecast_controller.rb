class ForecastController < ApplicationController
	def show
		begin
			@zip_code = params["zip_code"]
			if @zip_code.present?
				forecast_service = ForecastService.new('api_key')
				#caching the forecast request for 30 minutes
				@forecast_cache_exists = Rails.cache.exist?(@zip_code) 
				@forecast = Rails.cache.fetch(@zip_code, expires_in: 30.minutes) do
					forecast_service.get_forecast_data(@zip_code)
				end
			end 
		rescue => e
			flash[:alert] = e.message
		end
	end

	private

	def forecast_params
		params.permit(:zip_code)
	end
end
