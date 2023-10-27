require 'rails_helper'

RSpec.describe "ForecastService", type: :request do
  describe "get_forecast_data" do
    it 'return forecast data' do
      zip_code = Faker::Address.zip
      forecast = ForecastService.new('renuka.s07').get_forecast_data(zip_code)
       expect(forecast["temp_min"]).to be_present
       expect(forecast["temp_max"]).to be_present
       expect(forecast["temp"]).to be_present
       expect(forecast["humidity"]).to be_present
    end
  end
end
