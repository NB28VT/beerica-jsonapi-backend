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
    # Testing with Vermont
    state = @states.find(45)

    breweries = self.get_state_breweries(state.name)

    binding.pry

    # self.build_brewery(breweries.first, state)

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

    brewery = Brewery.create(
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

      # Images
      icon_image: brewery[:brewery][:images][:icon],
      medium_image: brewery[:brewery][:images][:medium],
      large_image: brewery[:brewery][:images][:large],
      square_medium_image: brewery[:brewery][:images][:square_medium],
      square_large_image: brewery[:brewery][:images][:square_large]
    )


    if brewery.save
      stock_beers(brewery)
    end
  end


  def stock_beers(brewery)
    beers_path = "http://api.brewerydb.com/v2/brewery/#{brewery.brewery_db_id}/beers?key=#{ENV['BREWERY_DB_API_TOKEN']}"

    c = Curl.get(beers_path) do |cc|
      cc.connect_timeout = 60
      cc.timeout = 300
    end

    response = JSON.parse(c.body_str)

    if response[:data]
      # Dry this up
      beer = response[:data]

      # Keep working on this with this data:
      # http://www.brewerydb.com/developers/docs-endpoint/brewery_beer

      Beer.create(
        brewery: brewery,
        name: beer[:name],
        abv: beer[:abv],

        # new rows
        # desc text!!
        description: beer[:description],
        style: beer[:style][:name],

      icon_image: brewery[:brewery][:images][:icon],
      medium_image: brewery[:brewery][:images][:medium],
      large_image: brewery[:brewery][:images][:large],
      square_medium_image: brewery[:brewery][:images][:square_medium],
      square_large_image: brewery[:brewery][:images][:square_large]        








      )
    end
  end



    # Hardcode for testing:

    # beers = brewery_db.brewery(brewery.brewery_db_id).beers


  end


  def get_state_breweries(state)
    @brewery_db.locations.all(region: state)
  end


end