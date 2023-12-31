**Weather Forecast to capture temperature**

**Scope:** 
```
1. Use Ruby on Rails
2. Accept zipcode as input
3. retrieve forecast data for given zip code
4. display temperature details to user
5. caching the details based upon zipcode for 30 mins
```
**Setup:**

**Install Ruby**
```
$asdf plugin add ruby
$asdf install ruby latest
$asdf global ruby latest
```
**Install Rails**

$gem install rails

**App Installation**

rails new weather-forecast --skip-activerecord # as we are storing any data in database, skipping active record

cd weather-forecast

**Gems used**
```ruby

gem 'httparty' #for calling third party services

gem 'bootstrap', '~> 5.3.2' #for form view
gem 'dotenv-rails' #for storing env variables
gem 'rspec-rails' #for unit testing
gem 'faker' #used for generating fake address details

bundle install
```

**Generated forecast controller**
```ruby
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
```


**Generated Service for getting weather using openweathermap**

```ruby

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
```

1. this method is used to fetch temperature detials using zip code.
2. for fetching country code using zip code, need to get api for **http://api.geonames.org** #test-api-key - renuka.s07
3. api key needs to be created in **https://api.openweathermap.org** #test-api key - 5d8fe2845978a2fe722e81462df41d66

```
Generated ForecastHelper for converting kelvin units to celsius

by default openweathermap units is in kelvin
```


**Sample Input before caching** 

Zip Code - 530041

**Output**
```
Zip Code - 530041
Temperature : 24.02°C
Min Temperature : 24.02°C
Max Temperature : 24.02°C
Humidity : 88
Temperature is cached? : false
```
**Sample Input after caching** 

Zip Code - 530041

**Output**
```
Zip Code - 530041
Temperature : 24.02°C
Min Temperature : 24.02°C
Max Temperature : 24.02°C
Humidity : 88
Temperature is cached? : true
```
