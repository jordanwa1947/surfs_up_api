# Surfs Up API

## Versions

Ruby version: ``ruby '2.6.2'``

Rails version: ``'rails', '~> 5.2.4'``

Database: Postgresql 12.1

##### Production:
-``gem 'rails', '~> 5.1.6'``
-``gem 'pg', '>= 0.18', '< 2.0'``
-``gem 'puma', '~> 3.7'``
-``gem 'rack-cors'``
-``gem 'httparty'``
-``gem 'nokogiri'``
-``gem 'fast_jsonapi'``

##### Testing & Development:
-``gem 'pry'``
-``gem 'rspec-rails'``
-``gem 'capybara'``
-``gem 'launchy'``
-``gem 'shoulda-matchers', '~> 3.1'``
-``gem 'vcr'``
-``gem 'webmock'``
-``gem 'shoulda-matchers', '>= 4.0.0'``
-``gem 'database_cleaner'``


## Setup

Running the rake db:seed command loads the entire
CSV file into the database
``rake db:{create,migrate,seed}``


Install Dependencies: ``bundle install``

## Web scraping

Running This command will visit every surfing spot's
endpoint on MagicSeaweed.com and add it's id,
coordinates and name to the CSV in the data directory.
This will write over whatever data you have in
that file and will likely take around two hours to
complete. The spot ids are used to create the url
necessary to retrieve a specific forecast for a location
``rake create_spots_csv``

##Routes

/api/v1/search/locations?query=string =>
case-insensitive, substring search returns all
matching locations with their ids

https://surf-forecast-api.herokuapp.com/api/v1/search/locations?query=newquay

```
{
    "data": [
        {
            "id": "1",
            "type": "spot",
            "attributes": {
                "id": 1,
                "spot_id": 1,
                "location": "Newquay - Fistral North",
                "latitude": 50.4184,
                "longitude": -5.0997
            }
        },
        {
            "id": "905",
            "type": "spot",
            "attributes": {
                "id": 905,
                "spot_id": 967,
                "location": "Newquay - Great Western",
                "latitude": 50.4162,
                "longitude": -5.0781
            }
        },
        {
            "id": "1211",
            "type": "spot",
            "attributes": {
                "id": 1211,
                "spot_id": 1336,
                "location": "Newquay - Tolcarne Wedge",
                "latitude": 50.4176,
                "longitude": -5.0749
            }
        },
        {
            "id": "1212",
            "type": "spot",
            "attributes": {
                "id": 1212,
                "spot_id": 1337,
                "location": "Newquay - Porth",
                "latitude": 50.4256,
                "longitude": -5.0659
            }
        },
        {
            "id": "1223",
            "type": "spot",
            "attributes": {
                "id": 1223,
                "spot_id": 1360,
                "location": "Newquay-  Little Fistral",
                "latitude": 50.4229,
                "longitude": -5.1
            }
        },
        {
            "id": "1224",
            "type": "spot",
            "attributes": {
                "id": 1224,
                "spot_id": 1361,
                "location": "Newquay - Fistral South ",
                "latitude": 50.4141,
                "longitude": -5.1025
            }
        },
        {
            "id": "1225",
            "type": "spot",
            "attributes": {
                "id": 1225,
                "spot_id": 1362,
                "location": "Newquay - Cribbar",
                "latitude": 50.4254,
                "longitude": -5.1026
            }
        },
        {
            "id": "5019",
            "type": "spot",
            "attributes": {
                "id": 5019,
                "spot_id": 6025,
                "location": "Newquay - Towan",
                "latitude": 50.4175,
                "longitude": -5.0841
            }
        }
    ]
}
```

/api/v1/locations => returns all locations with their ids

https://surf-forecast-api.herokuapp.com/locations
```
{
    "data": [
        {
            "id": "1",
            "type": "spot",
            "attributes": {
                "id": 1,
                "spot_id": 1,
                "location": "Newquay - Fistral North",
                "latitude": 50.4184,
                "longitude": -5.0997
            }
        },
        {
            "id": "2",
            "type": "spot",
            "attributes": {
                "id": 2,
                "spot_id": 2,
                "location": "Porthtowan",
                "latitude": 50.2891,
                "longitude": -5.2461
            }
        },
...
```
/api/v1/:spot_id/surf => returns the current surf at a location

```
{
    "data": {
        "id": "1",
        "type": "forecast",
        "attributes": {
            "faded_rating": 0,
            "solid_rating": 3,
            "issue_timestamp": "Wed Jan  1 06:00:00 2020",
            "local_timestamp": "Wed Jan  1 21:00:00 2020",
            "min_break_height": 2,
            "max_break_height": 4,
            "wave_unit": "ft",
            "wind_direction": "S",
            "wind_speed": 9,
            "wind_gusts": 12,
            "wind_unit": "mph",
            "temperature": 47,
            "temperature_unit": "f",
            "charts": {
                "swell": "https://charts-s3.msw.ms/archive/wave/750/1-1577912400-1.gif",
                "period": "https://charts-s3.msw.ms/archive/wave/750/1-1577912400-2.gif",
                "wind": "https://charts-s3.msw.ms/archive/gfs/750/1-1577912400-4.gif",
                "pressure": "https://charts-s3.msw.ms/archive/gfs/750/1-1577912400-3.gif"
            },
            "location": {
                "id": 1,
                "spot_id": 1,
                "location": "Newquay - Fistral North",
                "latitude": 50.4184,
                "longitude": -5.0997
            }
        }
    }
}
```
