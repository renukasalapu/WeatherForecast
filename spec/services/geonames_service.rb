require 'rails_helper'

RSpec.describe "GeonamesService", type: :request do
  describe "get_country_with_zip" do
    it 'return country with zip' do
      geoname = GeonamesService.new('5d8fe2845978a2fe722e81462df41d66').get_country_with_zip(530041)
       expect(geoname).to eq('530041,in')
    end
  end
end
