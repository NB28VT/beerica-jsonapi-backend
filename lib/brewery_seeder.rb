require 'json'
require 'dotenv'

class BrewerySeeder

  def initialize
    @brewery_db = BreweryDB::Client.new do |config|
      config.api_key = ENV['BREWERY_DB_API_TOKEN']
    end

    @states = State.all    
  end

  def seed_breweries
    # Testing with Vermont, limited batch
    state = @states.find(45)

    breweries = self.get_state_breweries(state.name).first(20)

    breweries.each do |brewery|
      self.build_brewery(brewery, state)
    end

    # @states.each do |state|
    #   breweries = self.get_state_breweries(state.name)

    #   breweries.each do |brewery|
    #     self.build_brewery(brewery, state)
    #   end
    # end
  end

  def build_brewery(brewery, state)    
    if brewery[:open_to_public] == "Y"
      open_to_public = true
    else
      open_to_public = false
    end

    new_brewery = Brewery.create(
      brewery_db_id: brewery[:id],
      state: state,
      name: brewery[:brewery][:name],
      address: brewery[:street_address],
      city: brewery[:locality],
      postal_code: brewery[:postal_code],
      latitude: brewery[:latitude],
      longitude: brewery[:longitude],

      open_to_public: open_to_public,

      description: brewery[:brewery][:description],
      website: brewery[:brewery][:website],
      established: brewery[:brewery][:established],

    )

    # Images

    if brewery[:brewery][:images]
      new_brewery.icon_image = brewery[:brewery][:images][:icon]
      new_brewery.medium_image = brewery[:brewery][:images][:medium]
      new_brewery.large_image = brewery[:brewery][:images][:large]
      new_brewery.square_medium_image = brewery[:brewery][:images][:square_medium]
      new_brewery.square_large_image = brewery[:brewery][:images][:square_large]
    end

    if new_brewery.save
      stock_beers(new_brewery)
    end
  end


  def stock_beers(brewery)
    beers_path = "http://api.brewerydb.com/v2/brewery/#{brewery.brewery_db_id}/beers?key=#{ENV['BREWERY_DB_API_TOKEN']}"

    c = Curl.get(beers_path) do |cc|
      cc.connect_timeout = 60
      cc.timeout = 300
    end

    response = JSON.parse(c.body_str)

    puts ap response

    if response["data"]
      # Dry this up
      beer = response["data"][0]

      # Here is the available beer data:
      # http://www.brewerydb.com/developers/docs-endpoint/brewery_beer
      
      new_beer = Beer.create(
        brewery: brewery,
        name: beer["name"],
        abv: beer["abv"],
        description: beer["description"],
      )

      if beer["style"]
        new_beer.style = beer["style"]["name"]
      end

      new_beer.save
    end
  end


  def get_state_breweries(state)
    @brewery_db.locations.all(region: state)
  end


end