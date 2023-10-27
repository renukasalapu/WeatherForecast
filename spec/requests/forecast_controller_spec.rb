require 'rails_helper'

RSpec.describe "ForecastControllers", type: :request do
  describe "GET /show" do
    it 'return error if zip code not present' do
      get '/fetch_forecast'
      expect(flash[:notice]).to eq("Zip Code can't be blank")
    end

    it 'caches the request' do
      get '/fetch_forecast', params: {zip_code: '530041'}
      expect(response).to have_http_status(200)
    end

  end
end
